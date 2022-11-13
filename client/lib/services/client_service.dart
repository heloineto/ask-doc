import 'dart:io';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum ConnectionStatus { connected, loading, disconnected }

class ClientService extends ChangeNotifier {
  Socket? socket;
  ConnectionStatus status = ConnectionStatus.disconnected;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  ClientService({required this.scaffoldKey});

  void connect({
    required String ip,
    required int port,
    Function(Object error)? onError,
    Function? onConnect,
    Function? onDisconnect,
  }) async {
    try {
      socket = await Socket.connect(ip, port);
    } catch (error) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: $error",
        backgroundColor: TW3Colors.red.shade500,
      );

      // if (onError != null) onError(error);
      return;
    }

    if (socket == null) {
      return;
    }

    // if (onConnect != null) onConnect();
    showSnackBarWithKey(
      scaffoldKey,
      "Connected",
      backgroundColor: TW3Colors.green.shade500,
    );
    status = ConnectionStatus.connected;

    debugPrint("Client: Connected to ${socket!.remoteAddress.address}");

    socket!.listen(
      (event) {},
      onError: (error) {
        debugPrint("ON ERROR");

        debugPrint("Client: Socket error: $error");

        socket!.destroy();
      },
      onDone: () {
        debugPrint("ON DONE");

        debugPrint("Client: Socket done");

        socket!.destroy();
      },
    );

    socket!.done.then((value) {
      debugPrint("DONE");

      // if (onDisconnect != null) onDisconnect();

      showSnackBarWithKey(
        scaffoldKey,
        "Disconnect",
        backgroundColor: TW3Colors.red.shade500,
      );

      status = ConnectionStatus.disconnected;
      notifyListeners();
    });
  }

  void disconnect() async {
    if (socket == null) {
      return;
    }

    await socket!.close();
  }

  void login() {}

  void register() {}
}
