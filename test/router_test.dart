import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_good_shepherd/providers/auth_provider.dart';
import 'package:the_good_shepherd/router/app_router.dart';
import 'package:the_good_shepherd/screens/auth/login/login_screen.dart';
import 'package:the_good_shepherd/screens/dashboard/dashboard_screen.dart';
import 'package:the_good_shepherd/screens/profile/profile_screen.dart';
import 'package:the_good_shepherd/screens/settings/settings_screen.dart';
import 'package:the_good_shepherd/screens/parents/parents_screen.dart'; // For /spiritual-fathers
import 'package:the_good_shepherd/screens/parent_dashboard/parent_dashboard_screen.dart';


// Mock AuthProvider
class MockAuthProvider extends ChangeNotifier implements AuthProvider {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _error;

  @override
  bool get isLoggedIn => _isLoggedIn;
  @override
  bool get isLoading => _isLoading;
  @override
  String? get error => _error;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  @override
  Future<void> login(String email, String password) async {}
  @override
  Future<void> register({
    String? fullName,
    String? churchName,
    String? phoneNumber,
    String? area,
    String? address,
    String? password,
    int? age,
    String? gender,
    String? email,
  }) async {}
  @override
  Future<void> logout() async {}
}

void main() {
  late MockAuthProvider mockAuthProvider;
  late GoRouter router;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    // We need to ensure AppRouter.createRouter can access the mockAuthProvider
    // This typically means AppRouter.createRouter needs to accept AuthProvider or use a static accessor
    // For this test, we'll assume AppRouter.createRouter uses the Provider internally for redirects.
    // The actual router creation for test will be wrapped in a MultiProvider.
  });

  Widget createTestApp(Widget child, GoRouter testRouter) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: mockAuthProvider,
      child: MaterialApp.router(
        routerConfig: testRouter,
      ),
    );
  }

  group('AppRouter Tests', () {
    testWidgets('redirects to /login if not logged in and accessing /home', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(false);
      router = AppRouter.createRouter(); // Router uses the provider via context

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/home');
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('allows access to /login if not logged in', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(false);
      router = AppRouter.createRouter();

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/login');
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('redirects to /home if logged in and accessing /login', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(true);
      router = AppRouter.createRouter();

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/login');
      await tester.pumpAndSettle();

      expect(find.byType(DashboardScreen), findsOneWidget); // Assuming /home shows DashboardScreen
    });

    testWidgets('navigates to /home (DashboardScreen) when logged in', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(true);
      router = AppRouter.createRouter();

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/home');
      await tester.pumpAndSettle();

      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    testWidgets('navigates to /profile when logged in', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(true);
      router = AppRouter.createRouter();

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/profile');
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('navigates to /settings when logged in', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(true);
      router = AppRouter.createRouter();

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/settings');
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('navigates to /spiritual-fathers (ParentsScreen) when logged in', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(true);
      router = AppRouter.createRouter();

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/spiritual-fathers');
      await tester.pumpAndSettle();

      expect(find.byType(ParentsScreen), findsOneWidget);
    });

    testWidgets('navigates to /parent-dashboard (ParentDashboardScreen) when logged in', (WidgetTester tester) async {
      mockAuthProvider.setLoggedIn(true);
      router = AppRouter.createRouter();

      await tester.pumpWidget(createTestApp(Container(), router));
      router.go('/parent-dashboard');
      await tester.pumpAndSettle();

      expect(find.byType(ParentDashboardScreen), findsOneWidget);
    });
  });
}
