import 'package:go_router/go_router.dart';
// TODO: Import all main screen entry points here
import 'package:the_good_shepherd/screens/auth/login/login_screen.dart';
import 'package:the_good_shepherd/screens/auth/register_screen.dart';
import 'package:the_good_shepherd/screens/dashboard_screen.dart';
import 'package:the_good_shepherd/screens/profile_screen.dart';
import 'package:the_good_shepherd/screens/panic_screen.dart';
import 'package:the_good_shepherd/screens/parents_screen.dart';
import 'package:the_good_shepherd/screens/parent/parent_dashboard/parent_dashboard_screen.dart';
// ...add other screens as needed

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(path: '/dashboard', builder: (context, state) => DashboardScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    GoRoute(path: '/panic', builder: (context, state) => PanicScreen()),
    GoRoute(path: '/parents', builder: (context, state) => ParentsScreen()),
    GoRoute(
      path: '/parent-dashboard',
      builder: (context, state) => ParentDashboardScreen(),
    ),
    // TODO: Add more routes for each screen as you implement them
  ],
);
