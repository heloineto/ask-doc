import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void sendChatRequest(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (response["success"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "Pedido de chat enviado",
      backgroundColor: TW3Colors.emerald.shade500,
    );
    return;
  }

  showSnackBarWithKey(
    scaffoldKey,
    "Erro: pedido de chat não foi enviado",
    backgroundColor: TW3Colors.red.shade500,
  );
}
