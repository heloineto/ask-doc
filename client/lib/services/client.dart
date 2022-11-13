import 'dart:io';
import 'package:flutter/material.dart';

class Client extends ChangeNotifier {
  Socket? socket;

  Client();

  void connect({
    required String ip,
    required int port,
    Function? onConnect,
    Function? onDisconnect,
  }) async {
    socket = await Socket.connect(ip, port);

    if (onConnect != null) onConnect();
    debugPrint("Client: Connected to ${socket!.remoteAddress.address}");

    socket!.listen(
      (event) {},
      onError: (error) {
        debugPrint("Client: Socket error: $error");

        socket!.destroy();
      },
      onDone: () {
        debugPrint("Client: Socket done");

        if (onDisconnect != null) onDisconnect();
        socket!.destroy();
      },
    );
  }

  void login() {}

  void register() {}
}
