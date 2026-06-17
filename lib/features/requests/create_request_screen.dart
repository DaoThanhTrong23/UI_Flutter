import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import 'requests_view_model.dart';

class CreateRequestScreen extends ConsumerStatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  ConsumerState<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends ConsumerState<CreateRequestScreen> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _removeDiacritics(String str) {
    const withDiacritics = 'àáãạảăằắẳẵặâầấẩẫậèéẹẻẽêềếểễệđìíĩỉịòóõọỏôồốổỗộơờớởỡợùúũụủưừứửữựỳýỵỷỹ';
    const withoutDiacritics = 'aaaaaaaaaaaaaaaaaeeeeeeeeeeediiiiiooooooooooooooooouuuuuuuuuuuyyyyy';
    for (int i = 0; i < withDiacritics.length; i++) {
      str = str.replaceAll(withDiacritics[i], withoutDiacritics[i]);
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    final requestTypesAsync = ref.watch(requestTypesProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/requests');
            }
          },
        ),
        title: const Text('Danh sách yêu cầu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFC3E8FF), width: 2),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: const Icon(Icons.person, color: AppColors.primary, size: 24),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor, 
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm loại yêu cầu...',
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                    suffixIcon: _searchQuery.isNotEmpty 
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    fillColor: Colors.transparent,
                  ),
                  onChanged: (v) {
                    setState(() {
                      _searchQuery = v;
                    });
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: requestTypesAsync.when(
              data: (allTypes) {
                var types = allTypes;
                
                if (_searchQuery.isNotEmpty) {
                  final queryNormalized = _removeDiacritics(_searchQuery.toLowerCase());
                  types = types.where((t) {
                    final nameNormalized = _removeDiacritics(t['name'].toString().toLowerCase());
                    return nameNormalized.contains(queryNormalized);
                  }).toList();
                }

                if (types.isEmpty && _searchQuery.isNotEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text('Không tìm thấy loại yêu cầu nào phù hợp.'),
                      ),
                    ),
                  );
                }

                if (types.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('Không có loại yêu cầu nào.')),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == types.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 32),
                          child: Opacity(
                            opacity: 0.5,
                            child: Column(
                              children: [
                                Icon(Icons.support_agent, size: 56, color: Theme.of(context).iconTheme.color),
                                const SizedBox(height: 16),
                                Text(
                                  'Không tìm thấy yêu cầu bạn cần?\nHãy liên hệ Văn phòng hỗ trợ sinh viên HUIT.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      final t = types[index];
                      // Gán icon ngẫu nhiên hoặc mặc định
                      IconData icon = Icons.description;
                      Color color = AppColors.primary;
                      Color bgColor = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF003050) : const Color(0xFFC3E8FF);
                      
                      if (t['name'].toString().toLowerCase().contains('thẻ')) {
                        icon = Icons.badge;
                      } else if (t['name'].toString().toLowerCase().contains('điểm')) {
                        icon = Icons.score;
                      } else if (t['name'].toString().toLowerCase().contains('vắng thi')) {
                        icon = Icons.event_busy;
                        color = AppColors.error;
                        bgColor = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF4A0005) : const Color(0xFFFFDAD6);
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildRequestTypeCard(
                          context: context,
                          requestType: t,
                          title: t['name'],
                          subtitle: 'Chọn để tạo yêu cầu ${t['name']}',
                          icon: icon,
                          color: color,
                          bgColor: bgColor,
                        ),
                      );
                    },
                    childCount: types.length + 1,
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
              error: (err, stack) => SliverToBoxAdapter(child: Center(child: Text('Lỗi: '))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestTypeCard({
    required BuildContext context,
    required Map<String, dynamic> requestType,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return InkWell(
      onTap: () {
        context.push('/requests/create/form', extra: requestType);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: color, width: 4)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Icon(Icons.chevron_right, color: Theme.of(context).dividerColor),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Theme.of(context).textTheme.titleLarge?.color),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodySmall?.color),
            ),
          ],
        ),
      ),
    );
  }
}
