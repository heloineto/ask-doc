import 'package:client/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: TW3Colors.zinc.shade900,
        child: Center(
          child: Container(
            width: 600,
            height: 386,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: TW3Colors.zinc.shade700,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
