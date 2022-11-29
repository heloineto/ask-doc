import 'package:client/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:client/services/client_service.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String cpf = '';
  String password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onSubmit() {
    FormState formState = _formKey.currentState!;

    if (!formState.validate()) {
      showSnackBar(context, "Form Invalid");
      return;
    }

    formState.save();

    context.read<ClientService>().login(cpf: cpf, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextInput(
            initialValue: cpf,
            onSaved: (value) {
              if (value != null) {
                cpf = value;
              }
            },
            label: Text("CPF"),
          ),
          SizedBox(height: 25),
          TextInput(
            initialValue: password,
            onSaved: (value) {
              if (value != null) {
                password = value;
              }
            },
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
                onSubmit();
                // Navigator.pushNamed(context, '/home');
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
