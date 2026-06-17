import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SystemInfoScreen extends StatelessWidget {
  const SystemInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1DA1F2), // primary from HTML
        foregroundColor: Colors.white,
        title: const Text('Thông tin hệ thống', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            // Brand/App Identity Hero Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  Transform.rotate(
                    angle: 0.05, // ~3 degrees
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE), // surface-container
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.png', // Assuming we have a logo, or fallback to an icon
                          width: 64,
                          height: 64,
                          errorBuilder: (_, __, ___) => const Icon(Icons.school, size: 48, color: Color(0xFF1DA1F2)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('HUIT Mobile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color)),
                  const SizedBox(height: 4),
                  Text('Cổng thông tin sinh viên', style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodySmall?.color)),
                ],
              ),
            ),
            
            // Info Grid Bento-style
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3.5, // 1 column layout, adjust ratio so it looks like the HTML cards
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildInfoCard(
                  context,
                  icon: Icons.settings,
                  iconBgColor: const Color(0xFFC3E8FF), // primary-fixed
                  iconColor: const Color(0xFF1DA1F2), // primary
                  title: 'PHIÊN BẢN',
                  value: '26.0.1',
                ),
                _buildInfoCard(
                  context,
                  icon: Icons.event_available,
                  iconBgColor: const Color(0xFFEEEEEE), // surface-container
                  iconColor: const Color(0xFF6D7981), // outline
                  title: 'NGÀY CẬP NHẬT',
                  value: '12/06/2026',
                ),
                _buildInfoCard(
                  context,
                  icon: Icons.groups,
                  iconBgColor: const Color(0xFFDEE0FF), // tertiary-fixed
                  iconColor: const Color(0xFF314DDF), // tertiary
                  title: 'NHÓM PHÁT TRIỂN',
                  value: 'VTV14',
                ),
                _buildInfoCard(
                  context,
                  icon: Icons.code,
                  iconBgColor: const Color(0xFFE2E2E2), // surface-container-highest
                  iconColor: const Color(0xFF3D4850), // on-surface-variant
                  title: 'NGÔN NGỮ PHÁT TRIỂN',
                  value: 'Flutter, Dart',
                ),
              ],
            ),
            
            const SizedBox(height: 48),
            // Footer
            Text(
              '© 2024 Đại học Công Thương TP. Hồ Chí Minh (HUIT)',
              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Ứng dụng chính thức dành cho sinh viên',
              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).dividerColor), // outline-variant
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodySmall?.color, // outline
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color, // on-surface
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
