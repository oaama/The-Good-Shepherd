import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Import all screens
// Note: Assuming screen paths from the original lib/router/app_router.dart are preferred.
// Paths from lib/core/router.dart that have equivalents here will use these paths.
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart'; // Corresponds to home_screen.dart
import '../screens/profile/profile_screen.dart';
import '../screens/panic/panic_screen.dart';
import '../screens/parents/parents_screen.dart'; // Corresponds to parent_dashboard_screen.dart
import '../screens/parent_content/parent_content_screen.dart';
import '../screens/sermon_library/sermon_library_screen.dart';
import '../screens/sermons/sermons_screen.dart';
import '../screens/daily_verse/daily_verse_screen.dart';
import '../screens/daily_advice/daily_advice_screen.dart';

// Screens that were only in lib/core/router.dart - adjust paths as necessary if they exist elsewhere
// For now, using the old paths and assuming they might need adjustment or are unique to core/router.dart
// If these screens are already covered by the above imports with different names, these specific GoRoute entries will be removed.
import '../screens/settings/settings_screen.dart'; // Moved screen
import '../screens/appointment/appointment_screen.dart'; // Moved screen
import '../screens/notifications/notifications_screen.dart'; // Moved screen
import '../screens/parent_dashboard/parent_dashboard_screen.dart'; // Moved screen (new route)

import '../providers/auth_provider.dart'; // From lib/core/router.dart

/// AppRouter provides a reusable GoRouter instance for the app.
class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshStream(_authStream()),
      routes: [
        GoRoute(
          path: '/login',
          name: 'login', // Added name
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          name: 'register', // Added name
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/home', // Path from core/router.dart
          name: 'home',  // Name from core/router.dart
          // Assuming DashboardScreen is the equivalent of HomeScreen
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/panic',
          name: 'panic', // Added name
          builder: (context, state) => const PanicScreen(),
        ),
        GoRoute(
          path: '/spiritual-fathers', // Path from core/router.dart
          name: 'spiritual-fathers', // Name from core/router.dart
          // Assuming ParentsScreen is the equivalent of ParentDashboardScreen
          builder: (context, state) => const ParentsScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile', // Added name
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
        // Routes that were unique to lib/router/app_router.dart (and not duplicates)
        // Note: /dashboard from original app_router.dart is now /home
        // Note: /parents from original app_router.dart is now /parent-dashboard
        GoRoute(
          path: '/parent-content',
          name: 'parent-content', // Added name
          builder: (context, state) => const ParentContentScreen(),
        ),
        GoRoute(
          path: '/sermon-library',
          name: 'sermon-library', // Added name
          builder: (context, state) => const SermonLibraryScreen(),
        ),
        GoRoute(
          path: '/sermons',
          name: 'sermons', // Added name
          builder: (context, state) => const SermonsScreen(),
        ),
        GoRoute(
          path: '/daily-verse',
          name: 'daily-verse', // Added name
          builder: (context, state) => const DailyVerseScreen(),
        ),
        GoRoute(
          path: '/daily-advice',
          name: 'daily-advice', // Added name
          builder: (context, state) => const DailyAdviceScreen(),
        ),
        GoRoute(
          path: '/parent-dashboard', // New route for the functional parent dashboard
          name: 'parent-dashboard',
          builder: (context, state) => const ParentDashboardScreen(),
        ),
      ],
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final loggedIn = authProvider.isLoggedIn;
        final loggingIn =
            state.fullPath == '/login' || state.fullPath == '/register';
        // TODO: Replace with backend auth guard logic
        if (!loggedIn && !loggingIn) return '/login';
        if (loggedIn && loggingIn) return '/home'; // Redirect to /home (was DashboardScreen)
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
