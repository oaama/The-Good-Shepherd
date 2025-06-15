import 'package:go_router/go_router.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/home/home_view.dart';
import '../views/settings/settings_view.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeView()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),
    // Add more routes as needed
  ],
);
