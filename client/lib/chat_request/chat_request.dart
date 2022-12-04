import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ChatRequestScreen extends StatelessWidget {
  const ChatRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Home",
      body: Center(
        child: Button(
          width: 250,
          twColor: TW3Colors.red,
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(PhosphorIcons.signOut),
              SizedBox(width: 10),
              Text(
                'Sair',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
