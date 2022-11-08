import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox(
            height: 52,
            width: 250,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.white;
                  },
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return TW3Colors.red.shade400;
                  },
                ),
              ),
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
        ),
      ),
    );
  }
}
