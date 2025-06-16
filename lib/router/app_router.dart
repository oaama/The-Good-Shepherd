import 'package:go_router/go_router.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/panic/panic_screen.dart';
import '../screens/parents/parents_screen.dart';
import '../screens/parent_content/parent_content_screen.dart';
import '../screens/sermon_library/sermon_library_screen.dart';
import '../screens/sermons/sermons_screen.dart';
import '../screens/daily_verse/daily_verse_screen.dart';
import '../screens/daily_advice/daily_advice_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(path: '/panic', builder: (context, state) => const PanicScreen()),
    GoRoute(
      path: '/parents',
      builder: (context, state) => const ParentsScreen(),
    ),
    GoRoute(
      path: '/parent-content',
      builder: (context, state) => const ParentContentScreen(),
    ),
    GoRoute(
      path: '/sermon-library',
      builder: (context, state) => const SermonLibraryScreen(),
    ),
    GoRoute(
      path: '/sermons',
      builder: (context, state) => const SermonsScreen(),
    ),
    GoRoute(
      path: '/daily-verse',
      builder: (context, state) => const DailyVerseScreen(),
    ),
    GoRoute(
      path: '/daily-advice',
      builder: (context, state) => const DailyAdviceScreen(),
    ),
  ],
);
