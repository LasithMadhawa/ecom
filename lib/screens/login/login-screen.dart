import 'package:ecom/screens/main_screen/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            SizedBox(
              width: 50.w,
              child: Image.asset('assets/images/login_vector.png')
              ),
            Text('Welcome', style: Theme.of(context).textTheme.headlineLarge,),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).disabledColor,),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide.none),
                hintText: "Email",
                hintStyle: TextStyle(color: Theme.of(context).disabledColor)
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 100.w,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) => const MainScreen()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none
                    )
                  )
                  ),
                
                child: Text("Login", style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),),),
            )
          ]),
        ),
      ),
    );
  }
}