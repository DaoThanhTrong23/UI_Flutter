import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'profile_view_model.dart';
import '../../core/theme/app_colors.dart';
import '../auth/auth_view_model.dart';
import '../../models/user_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/profile/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authViewModelProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(profileViewModelProvider),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Center(
                  child: Stack(
                    children: [
                      if (profile.avatarBase64 != null && safeDecodeBase64(profile.avatarBase64) != null)
                        ClipOval(
                          child: Image.memory(
                            safeDecodeBase64(profile.avatarBase64)!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person, size: 60, color: AppColors.primary),
                              );
                            },
                          ),
                        )
                      else if (profile.avatar != null && profile.avatar!.isNotEmpty)
                        ClipOval(
                          child: Image.network(
                            profile.avatar!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person, size: 60, color: AppColors.primary),
                              );
                            },
                          ),
                        )
                      else
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: const Icon(Icons.person, size: 60, color: AppColors.primary),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    profile.personal.fullName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    profile.personal.mssv,
                    style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 32),
                
                _buildSectionHeader(context, 'Thông tin học tập'),
                Card(
                  child: Column(
                    children: [
                      _buildInfoRow(context, 'Trạng thái', profile.academic.status, valueColor: AppColors.success),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Lớp', profile.academic.className),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Loại hình đào tạo', profile.academic.educationType),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Khóa học', profile.academic.course),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Ngành', profile.academic.major),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Chuyên ngành', profile.academic.specialization),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                _buildSectionHeader(context, 'Thông tin cá nhân'),
                Card(
                  child: Column(
                    children: [
                      _buildInfoRow(context, 'Ngày sinh', profile.personal.dob),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Giới tính', profile.personal.gender),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Nơi sinh', profile.personal.pob),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Số điện thoại', profile.personal.phone),
                      const Divider(height: 1),
                      _buildInfoRow(context, 'Email', profile.personal.email),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                ElevatedButton(
                  onPressed: () {
                    context.push('/profile/edit', extra: profile);
                  },
                  child: const Text('Cập nhật thông tin'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color),
            ),
          ),
        ],
      ),
    );
  }
}
