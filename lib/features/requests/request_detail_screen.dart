import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../profile/profile_view_model.dart';
import 'requests_view_model.dart';
import '../../models/request_model.dart';
import '../../repositories/data_repository.dart';

class DetailStep {
  final String title;
  final String date;
  final String status;
  final bool isCompleted;
  final bool isCurrent;

  const DetailStep({
    required this.title,
    required this.date,
    required this.status,
    required this.isCompleted,
    required this.isCurrent,
  });
}

class RequestDetailScreen extends ConsumerWidget {
  final String id;
  const RequestDetailScreen({super.key, required this.id});

  List<DetailStep> _getStepsForRequest(RequestModel request) {
    if (request.status == 'Hoàn thành') {
      return [
        DetailStep(
          title: 'Nộp yêu cầu',
          date: request.date,
          status: 'Đã tiếp nhận',
          isCompleted: true,
          isCurrent: false,
        ),
        const DetailStep(
          title: 'Phòng CTSV tiếp nhận',
          date: 'Kiểm tra hồ sơ thành công',
          status: 'Hồ sơ hợp lệ',
          isCompleted: true,
          isCurrent: false,
        ),
        const DetailStep(
          title: 'Xét duyệt hồ sơ',
          date: 'Duyệt cấp thành công',
          status: 'Đã hoàn thành',
          isCompleted: true,
          isCurrent: false,
        ),
        const DetailStep(
          title: 'Trả kết quả cho sv',
          date: 'Nhận kết quả trực tiếp',
          status: 'Đã hoàn thành',
          isCompleted: true,
          isCurrent: false,
        ),
      ];
    } else if (request.status == 'Từ chối') {
      return [
        DetailStep(
          title: 'Nộp yêu cầu',
          date: request.date,
          status: 'Đã tiếp nhận',
          isCompleted: true,
          isCurrent: false,
        ),
        const DetailStep(
          title: 'Phòng CTSV tiếp nhận',
          date: 'Kiểm tra hồ sơ',
          status: 'Hồ sơ không hợp lệ',
          isCompleted: true,
          isCurrent: false,
        ),
        const DetailStep(
          title: 'Xét duyệt hồ sơ',
          date: 'Từ chối duyệt',
          status: 'Bị từ chối',
          isCompleted: false,
          isCurrent: true,
        ),
      ];
    } else if (request.status == 'Hủy') {
      return [
        DetailStep(
          title: 'Nộp yêu cầu',
          date: request.date,
          status: 'Đã tiếp nhận',
          isCompleted: true,
          isCurrent: false,
        ),
        const DetailStep(
          title: 'Hủy yêu cầu',
          date: 'Yêu cầu đã bị hủy',
          status: 'Đã hủy',
          isCompleted: false,
          isCurrent: true,
        ),
      ];
    } else { // Chờ xử lý, Đang xử lý
      return [
        DetailStep(
          title: 'Nộp yêu cầu',
          date: request.date,
          status: 'Đã tiếp nhận',
          isCompleted: true,
          isCurrent: false,
        ),
        DetailStep(
          title: 'Phòng CTSV tiếp nhận',
          date: 'Xác minh hồ sơ',
          status: request.status == 'Đang xử lý' ? 'Hồ sơ hợp lệ' : 'Đang xử lý',
          isCompleted: request.status == 'Đang xử lý',
          isCurrent: request.status == 'Chờ xử lý',
        ),
        DetailStep(
          title: 'Chờ xét duyệt',
          date: 'Đang tiến hành xét duyệt',
          status: 'Đang xử lý',
          isCompleted: false,
          isCurrent: request.status == 'Đang xử lý',
        ),
        const DetailStep(
          title: 'Trả kết quả cho sv',
          date: 'Chưa đến bước này',
          status: 'Đang chờ',
          isCompleted: false,
          isCurrent: false,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final profileAsync = ref.watch(profileViewModelProvider);
    final requestsAsync = ref.watch(requestsViewModelProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
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
        title: const Text(
          'Chi tiết yêu cầu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: requestsAsync.when(
        data: (data) {
          final allRequests = data['requests'] as List<RequestModel>;
          final request = allRequests.firstWhere(
            (r) => r.id == id,
            orElse: () => RequestModel(
              id: id,
              title: 'Yêu cầu không tìm thấy',
              date: '',
              status: 'unknown',
            ),
          );

          if (request.status == 'unknown') {
            return Center(
              child: Text(
                'Không tìm thấy yêu cầu này.',
                style: theme.textTheme.titleMedium,
              ),
            );
          }

          final steps = _getStepsForRequest(request);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Summary Card
                profileAsync.when(
                  data: (profile) => Card(
                    elevation: theme.cardTheme.elevation ?? 4,
                    shadowColor: theme.cardTheme.shadowColor,
                    shape: theme.cardTheme.shape,
                    color: theme.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSummaryRow(context, 'Mã yêu cầu', '#${request.id}', isBoldValue: true, isPrimaryValue: true),
                          const Divider(height: 20),
                          _buildSummaryRow(context, 'Loại yêu cầu', request.title, isBoldValue: true),
                          const Divider(height: 20),
                          _buildSummaryRow(context, 'Sinh Viên', profile.personal.fullName, isBoldValue: true),
                          const Divider(height: 20),
                          _buildSummaryRow(context, 'MSSV', profile.personal.mssv, isBoldValue: true),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Trạng thái yêu cầu',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                              _buildStatusBadge(context, request.status),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  loading: () => const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (e, _) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: Text('Lỗi tải thông tin sinh viên: $e')),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                // Workflow Timeline Card
                Card(
                  elevation: theme.cardTheme.elevation ?? 4,
                  shadowColor: theme.cardTheme.shadowColor,
                  shape: theme.cardTheme.shape,
                  color: theme.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'QUY TRÌNH XỬ LÝ',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: steps.length,
                          itemBuilder: (context, index) {
                            final step = steps[index];
                            final isLast = index == steps.length - 1;

                            return IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left line & indicator column
                                  Column(
                                    children: [
                                      _buildStepIndicator(context, step),
                                      if (!isLast)
                                        Expanded(
                                          child: Container(
                                            width: 2,
                                            color: step.isCompleted
                                                ? const Color(0xFF00C853)
                                                : theme.dividerColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  // Right details column
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 24.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            step.title,
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: (step.isCompleted || step.isCurrent)
                                                  ? theme.colorScheme.onSurface
                                                  : theme.colorScheme.onSurface.withOpacity(0.4),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            step.date,
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: theme.colorScheme.onSurface.withOpacity(0.5),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            step.status,
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: _getStepStatusColor(step),
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
                  ),
                ),

                // Nút Hủy Yêu Cầu
                if (request.status == 'Chờ xử lý') ...[
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Hủy yêu cầu'),
                          content: const Text('Bạn có chắc chắn muốn hủy yêu cầu này không? Hành động này không thể hoàn tác.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Không'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(foregroundColor: Colors.red),
                              child: const Text('Hủy yêu cầu'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        // Gọi API
                        final repo = ref.read(dataRepositoryProvider);
                        final success = await repo.cancelRequest(request.id);
                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đã hủy yêu cầu thành công')),
                          );
                          // Refresh list
                          ref.invalidate(requestsViewModelProvider);
                          context.pop();
                        } else if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Hủy yêu cầu thất bại')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      foregroundColor: Colors.red,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.red, width: 1),
                      ),
                    ),
                    child: const Text(
                      'HỦY YÊU CẦU NÀY',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi tải thông tin yêu cầu: $e')),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isBoldValue = false, bool isPrimaryValue = false}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
            color: isPrimaryValue ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildStepIndicator(BuildContext context, DetailStep step) {
    final theme = Theme.of(context);
    if (step.isCompleted) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFF00C853), // Green
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        ),
      );
    } else if (step.isCurrent) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFFFF9800), // Yellow/Orange
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.pending,
          color: Colors.white,
          size: 16,
        ),
      );
    } else {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF151D26)
              : const Color(0xFFEEEEEE),
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      );
    }
  }

  Color _getStepStatusColor(DetailStep step) {
    if (step.isCompleted) {
      return const Color(0xFF00C853);
    } else if (step.isCurrent) {
      return const Color(0xFFFF9800);
    } else {
      return Colors.grey;
    }
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bg;
    Color text;
    String statusText;

    if (status == 'Đang xử lý') {
      bg = isDark 
          ? const Color(0xFF7AD0FF).withOpacity(0.15) 
          : const Color(0xFF00BFFF).withOpacity(0.15);
      text = isDark 
          ? const Color(0xFF7AD0FF) 
          : const Color(0xFF00668A);
      statusText = 'Đang xử lý';
    } else if (status == 'Chờ xử lý') {
      bg = isDark 
          ? const Color(0xFFFFB74D).withOpacity(0.15) 
          : const Color(0xFFFF9800).withOpacity(0.15);
      text = isDark 
          ? const Color(0xFFFFB74D) 
          : const Color(0xFFE65100);
      statusText = 'Chờ xử lý';
    } else if (status == 'Hoàn thành') {
      bg = const Color(0xFF00C853).withOpacity(0.15);
      text = const Color(0xFF00C853);
      statusText = 'Hoàn thành';
    } else if (status == 'Hủy') {
      bg = Colors.grey.withOpacity(0.15);
      text = Colors.grey.shade700;
      statusText = 'Đã hủy';
    } else { // Từ chối
      bg = const Color(0xFFEF4444).withOpacity(0.15);
      text = const Color(0xFFEF4444);
      statusText = 'Từ chối';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: text,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
