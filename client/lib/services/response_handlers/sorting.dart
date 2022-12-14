import 'package:client/utils/navigate_with_key.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void sorting(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!response["success"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "O servidor não permitiu a operação de triagem",
      backgroundColor: TW3Colors.red.shade500,
    );

    return;
  }

  navigateWithKey(
    '/patient_queue',
    scaffoldKey: scaffoldKey,
    navigatorKey: navigatorKey,
  );
}
