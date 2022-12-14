import 'package:client/utils/navigate_with_key.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void receiveChatRequest(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  navigateWithKey(
    '/chat_request',
    scaffoldKey: scaffoldKey,
    navigatorKey: navigatorKey,
  );

  showSnackBarWithKey(
    scaffoldKey,
    "Pedido de chat recebido",
    backgroundColor: TW3Colors.green.shade500,
  );
}
