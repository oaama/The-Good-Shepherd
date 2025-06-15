import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// Import all screens
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/home/home_screen.dart';
import '../views/panic/panic_screen.dart';
import '../views/parent/parent_dashboard_screen.dart';
import '../views/profile/profile_screen.dart';
import '../views/settings/settings_screen.dart';
import '../views/appointment/appointment_screen.dart';
import '../views/notifications/notifications_screen.dart';
import '../providers/auth_provider.dart';

/// AppRouter provides a reusable GoRouter instance for the app.
///
/// TODO: Add backend authentication guard logic in redirect section.
class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshStream(_authStream()),
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/panic',
          name: 'panic',
          builder: (context, state) => const PanicScreen(),
        ),
        GoRoute(
          path: '/parent-dashboard',
          name: 'parent-dashboard',
          builder: (context, state) => const ParentDashboardScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/appointment',
          name: 'appointment',
          builder: (context, state) => const AppointmentScreen(),
        ),
        GoRoute(
          path: '/notifications',
          name: 'notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
      ],
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final loggedIn = authProvider.isLoggedIn;
        final loggingIn =
            state.fullPath == '/login' || state.fullPath == '/register';
        // TODO: Replace with backend auth guard logic
        if (!loggedIn && !loggingIn) return '/login';
        if (loggedIn && loggingIn) return '/home';
        return null;
      },
    );
  }

  /// Helper to listen to AuthProvider changes for GoRouter refresh
  static Stream<void> _authStream() async* {
    // TODO: Replace with real auth state stream if needed
    // This is a dummy stream for GoRouter refresh
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield null;
    }
  }
}

/// Helper for GoRouter to listen to a stream
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<void> stream) {
    stream.listen((_) => notifyListeners());
  }
}
