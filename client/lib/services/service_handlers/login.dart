import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void login(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!response["status"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "Credenciais erradas",
      backgroundColor: TW3Colors.red.shade500,
    );

    return;
  }

  var navigatorState = navigatorKey.currentState;

  if (navigatorState == null) {
    showSnackBarWithKey(
      scaffoldKey,
      "navigatorState é null",
      backgroundColor: TW3Colors.red.shade500,
    );

    return;
  }

  navigatorState.pushNamed('/home');
}
