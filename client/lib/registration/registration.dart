import 'package:client/registration/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/shared/main_scaffold.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        color: TW3Colors.zinc.shade900,
        child: Center(
          child: Container(
            width: 600,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: TW3Colors.zinc.shade700,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RegistrationForm(),
                  Divider(height: 70),
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
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Voltar',
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
      ),
    );
  }
}
