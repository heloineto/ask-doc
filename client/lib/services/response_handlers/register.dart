import 'package:client/utils/navigate_with_key.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void register(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!response["success"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "Erro ao registrar",
      backgroundColor: TW3Colors.red.shade500,
    );

    return;
  }

  navigateWithKey(
    '/',
    scaffoldKey: scaffoldKey,
    navigatorKey: navigatorKey,
  );

  showSnackBarWithKey(
    scaffoldKey,
    "Registrado com sucesso",
    backgroundColor: TW3Colors.green.shade500,
  );
}
