import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'requests_view_model.dart';
import '../../models/request_model.dart';
import '../../core/theme/app_colors.dart';

class RequestListScreen extends ConsumerStatefulWidget {
  const RequestListScreen({super.key});

  @override
  ConsumerState<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends ConsumerState<RequestListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestsAsync = ref.watch(requestsViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text(
          'Yêu cầu của tôi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm yêu cầu...',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.5),
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
              tabs: const [
                Tab(text: 'TẤT CẢ'),
                Tab(text: 'ĐANG XỬ LÝ'),
                Tab(text: 'ĐÃ HOÀN THÀNH'),
              ],
            ),
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          Expanded(
            child: requestsAsync.when(
              data: (data) {
                var allRequests = data['requests'] as List<RequestModel>;

                if (_searchQuery.isNotEmpty) {
                  allRequests = allRequests
                      .where(
                        (r) =>
                            r.title.toLowerCase().contains(_searchQuery) ||
                            r.id.toLowerCase().contains(_searchQuery),
                      )
                      .toList();
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildRequestList(
                      [...allRequests]
                        ..sort((a, b) => b.date.compareTo(a.date)),
                    ),
                    _buildRequestList(
                      allRequests
                          .where(
                            (r) =>
                                r.status == 'Đang xử lý' ||
                                r.status == 'Chờ xử lý',
                          )
                          .toList(),
                    ),
                    _buildRequestList(
                      allRequests
                          .where(
                            (r) =>
                                r.status == 'Hoàn thành' ||
                                r.status == 'Từ chối' ||
                                r.status == 'Hủy',
                          )
                          .toList(),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/requests/create'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.post_add, size: 32),
      ),
    );
  }

  Widget _buildRequestList(List<RequestModel> requests) {
    if (requests.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(requestsViewModelProvider);
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final request = requests[index];

          Color borderColor;
          Color bgColor;
          Color textColor;
          String statusText;

          if (request.status == 'Đang xử lý' || request.status == 'Chờ xử lý') {
            borderColor = const Color(
              0xFF00BFFF,
            ); // primary-container from HTML (using a blueish color for pending)
            bgColor = const Color(0xFF00BFFF);
            textColor = const Color(0xFF004A65); // on-primary-container
            statusText = request.status;
          } else if (request.status == 'Hoàn thành') {
            borderColor = const Color(0xFF006E17); // secondary
            bgColor = const Color(0xFF5CFE62); // secondary-container
            textColor = const Color(0xFF007318); // on-secondary-container
            statusText = 'Đã hoàn thành';
          } else {
            borderColor = const Color(0xFFBA1A1A); // error
            bgColor = const Color(0xFFFFDAD6); // error-container
            textColor = const Color(0xFF93000A); // on-error-container
            statusText = request.status;
          }

          return Material(
            color: Theme.of(context).cardColor,
            elevation: Theme.of(context).cardTheme.elevation ?? 4,
            shadowColor: Theme.of(context).cardTheme.shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.4),
                width: 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => context.push('/requests/detail/${request.id}'),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: borderColor, width: 4),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            request.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Theme.of(
                                context,
                              ).textTheme.titleLarge?.color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.fingerprint,
                          size: 18,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(text: 'Mã yêu cầu: '),
                              TextSpan(
                                text: request.id.startsWith('YC-')
                                    ? '#${request.id}'
                                    : '#YC-${request.id}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Ngày gửi: ${request.date}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 192,
              height: 192,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBBN8Mgub3zOmi9T1l6eoAOCJ7nd6e7RIl0ZQz6sfpLiO1-rRrEugA_AJK1IcDdcee4zSDK7z5RyyJ33l5WqnKzi1XvsP5JS1zwe1Jgb_dxSTBUswyWbgFzyqTYaRS-8lng7I1XRxy67qYgqxYePiiA0brAlmjBf1nOtufG8gsCPpT0J5DyPWQPWc4iCn_nCA9hfHCQj8d4QcfvExzJq7qqGkY_HtmfPQDMpuVKEj4MC36o3fa1n4u3t3XvCbTYEe9Fcc6bQG4jkiw',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Không tìm thấy yêu cầu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Bạn chưa có yêu cầu nào trong danh mục này.',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
