import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_good_shepherd/providers/auth_provider.dart';
import 'package:the_good_shepherd/providers/user_provider.dart';
import 'package:the_good_shepherd/providers/panic_provider.dart';
import 'package:the_good_shepherd/providers/parent_provider.dart';
import 'package:the_good_shepherd/router/app_router.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

void main() {
  runApp(const TheGoodShepherdApp());
}

class TheGoodShepherdApp extends StatelessWidget {
  const TheGoodShepherdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PanicProvider()),
        ChangeNotifierProvider(create: (_) => ParentProvider()),
      ],
      child: MaterialApp.router(
        title: 'The Good Shepherd',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
