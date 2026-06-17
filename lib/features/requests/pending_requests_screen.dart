import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'requests_view_model.dart';
import '../../models/request_model.dart';

class RequestStep {
  final String title;
  final String description;
  final bool isCompleted;
  final bool isCurrent;

  const RequestStep({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.isCurrent,
  });
}

class PendingRequest {
  final String id;
  final String title;
  final String faculty;
  final String status;
  final String date;
  final int currentStep;
  final int totalSteps;
  final Color themeColor;
  final List<RequestStep> steps;

  const PendingRequest({
    required this.id,
    required this.title,
    required this.faculty,
    required this.status,
    required this.date,
    required this.currentStep,
    required this.totalSteps,
    required this.themeColor,
    required this.steps,
  });

  double get progress => currentStep / totalSteps;
}

class PendingRequestsScreen extends ConsumerStatefulWidget {
  const PendingRequestsScreen({super.key});

  @override
  ConsumerState<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends ConsumerState<PendingRequestsScreen> {
  String _searchQuery = '';
  // Remove hardcoded list

  void _showRequestDetails(BuildContext context, PendingRequest request) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bottom sheet handle
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: request.themeColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: request.themeColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mã yêu cầu: ${request.id}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(context, request, small: true),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: theme.dividerColor),
              const SizedBox(height: 16),
              
              // Progress description
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tiến trình xử lý',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Bước ${request.currentStep}/${request.totalSteps}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: request.themeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Stepper list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: request.steps.length,
                itemBuilder: (context, index) {
                  final step = request.steps[index];
                  final isLast = index == request.steps.length - 1;
                  
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indicator & Line Column
                        Column(
                          children: [
                            _buildStepIndicator(theme, step, request.themeColor),
                            if (!isLast)
                              Expanded(
                                child: Container(
                                  width: 2,
                                  color: step.isCompleted
                                      ? request.themeColor
                                      : theme.dividerColor,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // Step Content
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: step.isCurrent ? FontWeight.bold : FontWeight.w500,
                                    color: step.isCompleted
                                        ? theme.colorScheme.onSurface
                                        : step.isCurrent
                                            ? request.themeColor
                                            : theme.colorScheme.onSurface.withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  step.description,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: step.isCompleted || step.isCurrent
                                        ? theme.colorScheme.onSurface.withOpacity(0.6)
                                        : theme.colorScheme.onSurface.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepIndicator(ThemeData theme, RequestStep step, Color activeColor) {
    if (step.isCompleted) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: activeColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 14,
        ),
      );
    } else if (step.isCurrent) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: activeColor.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(color: activeColor, width: 2),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: theme.cardColor,
          shape: BoxShape.circle,
          border: Border.all(color: theme.dividerColor, width: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final requestsAsync = ref.watch(requestsViewModelProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Hero Header Section
          Container(
            color: theme.colorScheme.primary,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 28, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'HUIT CONNECT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () => context.push('/notifications'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đang chờ xử lý',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Danh sách các yêu cầu đang thực hiện',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Floating Search Bar & List Area
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 40,
                  child: Container(color: theme.colorScheme.primary),
                ),
                Column(
                  children: [
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                style: theme.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: 'Tìm kiếm yêu cầu...',
                                  hintStyle: TextStyle(
                                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  filled: false,
                                  fillColor: Colors.transparent,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Main list
                    Expanded(
                      child: requestsAsync.when(
                        data: (data) {
                          final allRequests = data['requests'] as List<RequestModel>;
                          
                          // Lọc các yêu cầu CHƯA HOÀN THÀNH và phù hợp search query
                          final filteredList = allRequests.where((req) {
                            final status = req.status;
                            final isPending = status != 'Hoàn thành' && status != 'Từ chối' && status != 'Hủy';
                            final title = req.title.toLowerCase();
                            final id = req.id.toLowerCase();
                            final matchesSearch = title.contains(_searchQuery.toLowerCase()) || id.contains(_searchQuery.toLowerCase());
                            return isPending && matchesSearch;
                          }).toList();

                          if (filteredList.isEmpty) return _buildEmptyState(theme);

                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                            itemCount: filteredList.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final req = filteredList[index];
                              
                              int currentStep = 1;
                              int totalSteps = 3;
                              Color color = const Color(0xFF1DA1F2);
                              final status = req.status;
                              
                              if (status == 'Đang xử lý') {
                                currentStep = 2;
                                color = const Color(0xFF314DDF);
                              } else if (status == 'Chờ xử lý') {
                                currentStep = 1;
                                color = const Color(0xFFFF9800);
                              }

                              final requestObj = PendingRequest(
                                id: req.id,
                                title: req.title,
                                faculty: 'HUIT',
                                status: status,
                                date: req.date,
                                currentStep: currentStep,
                                totalSteps: totalSteps,
                                themeColor: color,
                                steps: [
                                  RequestStep(title: 'Tiếp nhận yêu cầu', description: 'Đã nhận hồ sơ', isCompleted: currentStep > 1, isCurrent: currentStep == 1),
                                  RequestStep(title: 'Đang xử lý', description: 'Phòng ban đang giải quyết', isCompleted: currentStep > 2, isCurrent: currentStep == 2),
                                  RequestStep(title: 'Hoàn tất', description: 'Chờ trả kết quả', isCompleted: false, isCurrent: currentStep == 3),
                                ],
                              );

                              return _buildRequestCard(context, requestObj, theme);
                            },
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (err, stack) => Center(child: Text('Lỗi: $err')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/requests/create'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  // replaced above

  Widget _buildRequestCard(BuildContext context, PendingRequest req, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.cardColor,
      elevation: theme.cardTheme.elevation ?? 6,
      shadowColor: theme.cardTheme.shadowColor ?? Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withOpacity(0.4),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showRequestDetails(context, req),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent border bar matching requested color theme
              Container(
                width: 6,
                color: req.themeColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              req.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildStatusBadge(context, req),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Request ID text
                      Text(
                        req.id,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Info Row (Date & Step Status)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                req.date,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.dividerColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Bước ${req.currentStep}/${req.totalSteps}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Micro-progress bar
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF232D37) : const Color(0xFFE2E2E2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: req.progress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: req.themeColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, PendingRequest req, {bool small = false}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    Color bg;
    Color text;

    if (req.status == 'Đang xử lý') {
      bg = isDark 
          ? const Color(0xFF7AD0FF).withOpacity(0.15) 
          : const Color(0xFF00BFFF).withOpacity(0.15);
      text = isDark 
          ? const Color(0xFF7AD0FF) 
          : const Color(0xFF00668A);
    } else { // Chờ xử lý
      bg = isDark 
          ? const Color(0xFFFFB74D).withOpacity(0.15) 
          : const Color(0xFFFF9800).withOpacity(0.15);
      text = isDark 
          ? const Color(0xFFFFB74D) 
          : const Color(0xFFE65100);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 10 : 12, vertical: small ? 3 : 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        req.status,
        style: TextStyle(
          color: text,
          fontSize: small ? 10 : 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 72,
              color: theme.colorScheme.onSurface.withOpacity(0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'Không tìm thấy yêu cầu',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Không tìm thấy yêu cầu nào phù hợp với từ khóa của bạn.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
