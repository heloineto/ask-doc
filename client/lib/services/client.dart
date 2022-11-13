import 'dart:io';
import 'package:flutter/material.dart';

enum ConnectionStatus { connected, loading, disconnected }

class Client extends ChangeNotifier {
  Socket? socket;
  ConnectionStatus status = ConnectionStatus.disconnected;

  Client();

  void connect({
    required String ip,
    required int port,
    Function? onConnect,
    Function? onDisconnect,
  }) async {
    socket = await Socket.connect(ip, port);

    if (onConnect != null) onConnect();
    status = ConnectionStatus.connected;
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

    notifyListeners();

    socket!.done.then((value) {
      status = ConnectionStatus.disconnected;
      notifyListeners();
    });
  }

  void login() {}

  void register() {}
}
