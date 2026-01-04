import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/widgets/app_shell.dart';
import '../features/reminders/presentation/screens/reminders_list_screen.dart';
import '../features/reminders/presentation/screens/reminder_form_screen.dart';
import '../features/categories/presentation/screens/categories_screen.dart';
import '../features/notifications/presentation/screens/notification_center_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'reminders',
            builder: (context, state) => const RemindersListScreen(),
          ),
          GoRoute(
            path: '/reminder/new',
            name: 'new-reminder',
            builder: (context, state) => const ReminderFormScreen(),
          ),
          GoRoute(
            path: '/reminder/:id/edit',
            name: 'edit-reminder',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ReminderFormScreen(reminderId: id);
            },
          ),
          GoRoute(
            path: '/categories',
            name: 'categories',
            builder: (context, state) => const CategoriesScreen(),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notification-center',
            builder: (context, state) => const NotificationCenterScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
