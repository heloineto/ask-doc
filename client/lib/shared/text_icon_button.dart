import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class TextIconButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final void Function()? onPressed;
  final TWColor twColor;

  const TextIconButton({
    super.key,
    this.icon,
    required this.text,
    this.onPressed,
    this.twColor = TW3Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      twColor: twColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
