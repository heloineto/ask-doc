import 'package:client/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextInput(
            label: Text("CPF"),
          ),
          SizedBox(height: 25),
          TextInput(
            label: Text("Senha"),
          ),
          SizedBox(height: 25),
          SizedBox(
            height: 52,
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.white;
                  },
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return TW3Colors.emerald;
                  },
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
