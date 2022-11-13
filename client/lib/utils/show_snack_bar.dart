import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: TW3Colors.slate.shade100),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
