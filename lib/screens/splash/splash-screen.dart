import 'package:ecom/providers/auth.provider.dart';
import 'package:ecom/screens/login/login-screen.dart';
import 'package:ecom/screens/main_screen/main-screen.dart';
import 'package:ecom/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Checking auth state and navigate accordingly
  checkAuth(context) async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.initialize();
    Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 5), () {
    //     checkAuth(context);
    //   });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.initialize();
      if (authProvider.authState == AuthState.authenticated) {
        if (context.mounted) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const MainScreen()));
        }
      } else {
        if (context.mounted) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
        }
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}