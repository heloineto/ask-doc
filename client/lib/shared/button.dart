import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Button extends StatelessWidget {
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final Widget child;
  final TWColor twColor;

  const Button({
    Key? key,
    this.width,
    this.height = 52,
    this.onPressed,
    required this.child,
    this.twColor = TW3Colors.emerald,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
            (Set<MaterialState> states) {
              return EdgeInsets.symmetric(vertical: 10, horizontal: 20);
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.white;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return twColor.shade400;
            },
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
