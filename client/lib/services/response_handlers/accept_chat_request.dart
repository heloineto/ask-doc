import 'package:client/utils/navigate_with_key.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void acceptChatRequest(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  navigateWithKey(
    '/chat',
    scaffoldKey: scaffoldKey,
    navigatorKey: navigatorKey,
  );

  showSnackBarWithKey(
    scaffoldKey,
    "O pedido de chat foi aceito",
    backgroundColor: TW3Colors.green.shade500,
  );
}
