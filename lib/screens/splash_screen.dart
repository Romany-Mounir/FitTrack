import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; // to be created
import 'home_screen.dart'; // to be created

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _checkAuth);
  }

  void _checkAuth() {
    // final user = FirebaseAuth.instance.currentUser;
    // if (user == null) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) => const LoginScreen()),
    //   );
    // } else {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) => const HomeScreen()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
