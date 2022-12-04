import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void receiveChatRequest(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  var navigatorState = navigatorKey.currentState;

  if (navigatorState == null) {
    showSnackBarWithKey(
      scaffoldKey,
      "navigatorState é null",
      backgroundColor: TW3Colors.red.shade500,
    );
    return;
  }

  navigatorState.pushNamed('/chat_request');
  showSnackBarWithKey(
    scaffoldKey,
    "Pedido de chat recebido",
    backgroundColor: TW3Colors.green.shade500,
  );
}
