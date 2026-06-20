import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'state/app_state.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

void main() {
  runApp(const IsimVarApp());
}

class IsimVarApp extends StatelessWidget {
  const IsimVarApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Karanlık mod durumunu dinle; değişince tüm uygulama yeniden çizilir.
    return ValueListenableBuilder<bool>(
      valueListenable: AppState.instance.darkMode,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'İşimVar',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: _lightTheme,
          darkTheme: _darkTheme,
          initialRoute: '/',
          routes: {
            '/': (_) => const LoginScreen(),
            '/home': (_) => const HomeScreen(),
            '/detail': (_) => const DetailScreen(),
          },
        );
      },
    );
  }
}

final ThemeData _lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF1F5F9),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ),
);

final ThemeData _darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0F172A),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
  ),
);
