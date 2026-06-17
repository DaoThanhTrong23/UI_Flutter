import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'notifications_view_model.dart';
import '../../core/theme/app_colors.dart';
import '../../repositories/data_repository.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Thông báo'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Icon(Icons.person, color: AppColors.primary, size: 20),
            ),
          )
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) {
          final unread = notifications.where((n) => !n.isRead).toList();
          final read = notifications.where((n) => n.isRead).toList();

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(notificationsViewModelProvider),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (unread.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gần đây', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.done_all, size: 16, color: AppColors.primary),
                        label: const Text('Đánh dấu tất cả đã đọc', style: TextStyle(color: AppColors.primary, fontSize: 12)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...unread.map((n) => _buildNotificationCard(context, ref, n, true)),
                  const SizedBox(height: 16),
                ],
                if (read.isNotEmpty) ...[
                  Text('Trước đó', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...read.map((n) => _buildNotificationCard(context, ref, n, false)),
                ]
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, WidgetRef ref, notification, bool isUnread) {
    IconData icon;
    Color iconBgColor;
    switch (notification.type) {
      case 'request':
        icon = Icons.assignment;
        iconBgColor = AppColors.secondary;
        break;
      case 'schedule':
        icon = Icons.calendar_today;
        iconBgColor = AppColors.secondary.withOpacity(0.7);
        break;
      case 'grade':
        icon = Icons.school;
        iconBgColor = Colors.grey[300]!;
        break;
      case 'fee':
        icon = Icons.account_balance_wallet;
        iconBgColor = Colors.grey[300]!;
        break;
      default:
        icon = Icons.notifications;
        iconBgColor = Colors.grey[300]!;
    }

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: Colors.red,
        margin: const EdgeInsets.only(bottom: 12),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        final confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Xác nhận xóa"),
              content: const Text("Bạn có chắc chắn muốn xóa thông báo này không?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Xóa", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );

        if (confirm == true) {
          final repo = ref.read(dataRepositoryProvider);
          final success = await repo.deleteNotification(notification.id);
          
          if (success) {
            return true;
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Không thể xóa thông báo của trường')),
              );
            }
            return false;
          }
        }
        return false;
      },
      onDismissed: (direction) {
        ref.read(notificationsViewModelProvider.notifier).removeNotificationLocally(notification.id);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xóa thông báo')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isUnread ? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: AppColors.primary,
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.push('/notifications/${notification.id}'),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: iconBgColor,
                            radius: 24,
                            child: Icon(icon, color: isUnread ? Colors.white : Colors.grey[600]),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notification.title,
                                        style: TextStyle(
                                          fontWeight: isUnread ? FontWeight.normal : FontWeight.normal,
                                          fontSize: 16,
                                          color: isUnread ? Theme.of(context).textTheme.bodyLarge?.color : Theme.of(context).textTheme.bodySmall?.color,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      notification.date,
                                      style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  notification.content,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, height: 1.4),
                                ),
                              ],
                            ),
                          ),
                          if (isUnread) ...[
                            const SizedBox(width: 12),
                            const Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(radius: 4, backgroundColor: AppColors.primary),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
