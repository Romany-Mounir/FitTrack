import 'package:fit_track/screens/activity_screen.dart';
import 'package:fit_track/screens/health_example.dart';
import 'package:fit_track/screens/profile_page.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_page.dart';

sealed class AppRoutes {
  static const splash = '/';
  static const login = 'login';
  static const register = '/register';
  static const home = 'home';
  static const profile = '/profile';
  static const health = '/health_example';
  static const activity = '/activity';
}

class AppNavigator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case AppRoutes.health:
        return MaterialPageRoute(builder: (_) => const HealthApp());
      case AppRoutes.activity:
        return MaterialPageRoute(builder: (_) => const ActivityScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }

  static void push(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static void pushReplacement(
    BuildContext context,
    String route, {
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
