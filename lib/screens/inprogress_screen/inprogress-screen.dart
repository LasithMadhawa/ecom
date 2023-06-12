import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        SizedBox(
              width: 50.w,
              child: Image.asset('assets/images/in_progress.png')
              ),
              const SizedBox(height: 20,),
            Text('This page will be available soon!', style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 80,),
      ],)),
    );
  }
}