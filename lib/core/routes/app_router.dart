import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/requests/request_list_screen.dart';
import '../../features/requests/create_request_screen.dart';
import '../../features/requests/request_form_screen.dart';
import '../../features/notifications/notification_screen.dart';
import '../../features/notifications/notification_detail_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/settings_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/system_info/system_info_screen.dart';
import '../../features/system_info/faculty_contact_screen.dart';
import '../../features/requests/pending_requests_screen.dart';
import '../../features/requests/request_detail_screen.dart';
import '../widgets/main_screen.dart';
import '../utils/shared_prefs.dart';
import '../../models/user_model.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  redirect: (context, state) async {
    // API Laravel hiện tại không cấp Token, ta sẽ dựa vào phiên lưu MSSV
    final mssv = await SharedPrefs.getMssv();
    final isLoggingIn = state.matchedLocation == '/login';

    if (mssv == null && !isLoggingIn) return '/login';
    if (mssv != null && isLoggingIn) return '/';
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/requests',
              builder: (context, state) => const RequestListScreen(),
              routes: [
                GoRoute(
                  path: 'pending',
                  builder: (context, state) => const PendingRequestsScreen(),
                ),
                GoRoute(
                  path: 'detail/:id',
                  builder: (context, state) => RequestDetailScreen(id: state.pathParameters['id']!),
                ),
                GoRoute(
                  path: 'create',
                  builder: (context, state) => const CreateRequestScreen(),
                  routes: [
                    GoRoute(
                      path: 'form',
                      builder: (context, state) => RequestFormScreen(requestType: state.extra as Map<String, dynamic>),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notifications',
              builder: (context, state) => const NotificationScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => NotificationDetailScreen(id: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'system-info',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const SystemInfoScreen(),
                ),
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                ),
                GoRoute(
                  path: 'faculty-contact',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const FacultyContactScreen(),
                ),
                GoRoute(
                  path: 'edit',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => EditProfileScreen(profile: state.extra as UserProfileModel),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
