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
        style: TextStyle(color: TW3Colors.zinc.shade100),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}

void showSnackBarWithKey(
  GlobalKey<ScaffoldMessengerState> scaffoldKey,
  String message, {
  Color? backgroundColor,
}) {
  final ScaffoldMessengerState? scaffold = scaffoldKey.currentState;

  scaffold?.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: TW3Colors.zinc.shade100),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
