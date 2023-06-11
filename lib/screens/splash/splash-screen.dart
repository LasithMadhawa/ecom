import 'package:ecom/screens/login/login-screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Checking auth state and navigate accordingly
  checkAuth(context) {
    Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
        checkAuth(context);
      });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}