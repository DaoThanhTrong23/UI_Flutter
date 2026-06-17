import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../profile/profile_view_model.dart';
import '../requests/requests_view_model.dart';
import '../../models/request_model.dart';
import '../../models/user_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileViewModelProvider);
    final requestsAsync = ref.watch(requestsViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('HUIT CONNECT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.go('/notifications'),
          ),
        ],
      ),
      drawer: _buildDrawer(context, profileAsync),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(profileViewModelProvider);
          ref.invalidate(requestsViewModelProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Hero Welcome Section
            profileAsync.when(
              data: (profile) => Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Chào buổi sáng!', style: TextStyle(color: Colors.white70, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text(
                            profile.personal.fullName,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.school, size: 48, color: Colors.white24),
                  ],
                ),
              ),
              loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
              error: (e, _) => Text('Error loading profile: $e'),
            ),
            
            // Request Stats
            Text('Thống kê yêu cầu', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            requestsAsync.when(
              data: (data) {
                final stats = data['stats'] as RequestStatsModel;
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: [
                    _buildStatCard(context, 'Tổng yêu cầu', stats.total, AppColors.primary, Icons.assignment),
                    _buildStatCard(context, 'Đang xử lý', stats.processing, AppColors.secondary, Icons.pending_actions),
                    _buildStatCard(context, 'Hoàn thành', stats.completed, const Color(0xFF00C853), Icons.task_alt),
                    _buildStatCard(context, 'Bị hủy', stats.rejected, AppColors.error, Icons.cancel),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error loading stats: $e'),
            ),
            
            const SizedBox(height: 24),
            // Quick Actions
            Text('Thao tác nhanh', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildActionItem(context, Icons.add_circle, 'Tạo yêu cầu', AppColors.primary, () => context.push('/requests/create')),
                _buildActionItem(context, Icons.verified, 'Chương trình', const Color(0xFF00C853), () {

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chức năng đang được update :) ')));
                }),
                _buildActionItem(context, Icons.contact_support, 'Liên hệ khoa', Colors.grey[600]!, () => context.push('/profile/faculty-contact'), isGrey: true),
                _buildActionItem(context, Icons.pending_actions, 'Chờ xử lý', Colors.grey[600]!, () => context.push('/requests/pending'), isGrey: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, AsyncValue profileAsync) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          profileAsync.when(
            data: (profile) => Container(
              color: AppColors.primary,
              padding: const EdgeInsets.only(top: 60, bottom: 24, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white54, width: 2),
                      color: Colors.white,
                    ),
                    child: profile.avatarBase64 != null && safeDecodeBase64(profile.avatarBase64) != null
                        ? ClipOval(
                            child: Image.memory(
                              safeDecodeBase64(profile.avatarBase64)!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, size: 40, color: AppColors.primary);
                              },
                            ),
                          )
                        : profile.avatar != null && profile.avatar!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  profile.avatar!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.person, size: 40, color: AppColors.primary);
                                  },
                                ),
                              )
                            : const Icon(Icons.person, size: 40, color: AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                  const Text('Chào buổi sáng!', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(profile.personal.fullName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(profile.personal.mssv, style: const TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1.5)),
                ],
              ),
            ),
            loading: () => const DrawerHeader(decoration: BoxDecoration(color: AppColors.primary), child: Center(child: CircularProgressIndicator(color: Colors.white))),
            error: (_, __) => const DrawerHeader(decoration: BoxDecoration(color: AppColors.primary), child: Text('Lỗi tải thông tin')),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(context, Icons.home, 'Trang chủ', onTap: () => Navigator.pop(context), isActive: true),
                _buildDrawerItem(context, Icons.forward_to_inbox, 'Tạo yêu cầu', onTap: () { Navigator.pop(context); context.push('/requests/create'); }),
                _buildDrawerItem(context, Icons.format_list_bulleted, 'Yêu cầu của tôi', onTap: () { Navigator.pop(context); context.go('/requests'); }),
                _buildDrawerItem(context, Icons.schedule, 'Đang chờ xử lý', onTap: () { Navigator.pop(context); context.push('/requests/pending'); }),
                const Divider(height: 24, indent: 24, endIndent: 24),
                _buildDrawerItem(context, Icons.account_circle, 'Thông tin tài khoản', onTap: () { Navigator.pop(context); context.go('/profile'); }),
                _buildDrawerItem(context, Icons.settings, 'Cài đặt hệ thống', onTap: () { Navigator.pop(context); context.push('/profile/settings'); }),
                _buildDrawerItem(context, Icons.info, 'Thông tin ứng dụng', onTap: () { Navigator.pop(context); context.push('/profile/system-info'); }),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('Phiên bản 1.0.0', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, {required VoidCallback onTap, bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: ListTile(
        leading: Icon(icon, color: isActive ? AppColors.primary : Theme.of(context).iconTheme.color),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primary : Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, int count, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const Spacer(),
          Text(title, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(
            count.toString().padLeft(1, '0'),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap, {bool isGrey = false}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isGrey ? Theme.of(context).cardColor : color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: isGrey ? Theme.of(context).iconTheme.color : Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.bodySmall?.color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
