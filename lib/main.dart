import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'router/app_router.dart';
import 'services/api_service.dart';
import 'providers/sermon_provider.dart';
import 'providers/daily_verse_provider.dart';
import 'providers/daily_advice_provider.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const TheGoodShepherdApp());
}

class TheGoodShepherdApp extends StatelessWidget {
  const TheGoodShepherdApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SermonProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => DailyVerseProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => DailyAdviceProvider(apiService: apiService),
        ),
      ],
      child: MaterialApp.router(
        title: 'The Good Shepherd',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.createRouter(),
      ),
    );
  }
}
