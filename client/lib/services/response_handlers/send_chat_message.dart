import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void sendChatMessage(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (response["success"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "Mensagem recebida",
      backgroundColor: TW3Colors.emerald.shade500,
    );
    return;
  }

  showSnackBarWithKey(
    scaffoldKey,
    "Erro: Mensagem não recebida",
    backgroundColor: TW3Colors.red.shade500,
  );
}
