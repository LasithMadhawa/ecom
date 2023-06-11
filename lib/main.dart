import 'package:ecom/screens/splash/splash-screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            title: 'Ecom',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 157, 110, 0),
                brightness: Brightness.light,
                primary: const Color.fromARGB(255, 255, 157, 0),
                secondary: const Color.fromARGB(255, 184, 31, 0),
                background: const Color.fromARGB(255, 238, 238, 238),
              ),
              useMaterial3: true,
            ),
            home: const SplashScreen());
      },
    );
  }
}
