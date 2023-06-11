import 'package:ecom/providers/auth.provider.dart';
import 'package:ecom/screens/main_screen/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailRegex =
      RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();
  bool _loginFailed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
            return Container(
          constraints: BoxConstraints(minHeight: 100.h),
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                    width: 50.w,
                    child: Image.asset('assets/images/login_vector.png')),
                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value?.replaceAll(" ", "") == null ||
                        value!.replaceAll(" ", "").isEmpty) {
                      return 'Please enter your email';
                    } else if (!_emailRegex.hasMatch(value.replaceAll(" ", ""))) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: _emailCtrl,
                  decoration: _inputDecoration("Email", Icons.email_outlined),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: _pwdCtrl,
                  obscureText: true,
                  decoration: _inputDecoration("Password", Icons.lock_outline_rounded),
                ),
                if (_loginFailed)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Your email or password is incorrect. Try again!", softWrap: true, style: TextStyle(color: Theme.of(context).colorScheme.error),),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 100.w,
                  child: TextButton(
                    onPressed: authProvider.authState == AuthState.loading ? null : () {
                      _onSubmit(authProvider);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             const MainScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide.none))),
                    child: Text(
                     authProvider.authState == AuthState.loading ? "Logging In..." : "Login",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
          },)
        )
      ),
    );
  }

  _inputDecoration(String hintText, IconData prefixIcon) {
    return InputDecoration(
        filled: true,
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).disabledColor,
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
                style: BorderStyle.solid)),
        errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
                style: BorderStyle.solid)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).disabledColor));
  }

  _onSubmit(AuthProvider authProvider) async {
    _loginFailed = false;
    final form = _formKey.currentState;
    form!.validate();
    form.save();
    if (form.validate()) {
      try {
        await authProvider.login(_emailCtrl.text, _pwdCtrl.text);
        if (authProvider.authState == AuthState.authenticated) {
          if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const MainScreen()));
          }
        } else {
          setState(() {
            _loginFailed = true;
            // _emailCtrl.clear();
            // _pwdCtrl.clear();
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
