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
      backgroundColor: backgroundColor ?? TW3Colors.blue.shade500,
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
        style: TextStyle(color: TW3Colors.slate.shade100),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
