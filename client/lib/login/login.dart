import 'package:client/login/login_form.dart';
import 'package:client/shared/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Container(
        color: TW3Colors.zinc.shade900,
        child: Center(
          child: Container(
            width: 600,
            height: 390,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: TW3Colors.zinc.shade700,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                LoginForm(),
                Divider(height: 80),
                SizedBox(
                  height: 52,
                  width: 250,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.white;
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return TW3Colors.blue;
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
