import 'dart:io';
import 'package:flutter/material.dart';

enum ConnectionStatus { connected, loading, disconnected }

class ClientService extends ChangeNotifier {
  Socket? socket;
  ConnectionStatus status = ConnectionStatus.disconnected;

  ClientService();

  void connect({
    required String ip,
    required int port,
    Function? onConnect,
    Function? onDisconnect,
  }) async {
    socket = await Socket.connect(ip, port);

    if (socket == null) {
      return;
    }

    if (onConnect != null) onConnect();
    status = ConnectionStatus.connected;
    notifyListeners();

    debugPrint("Client: Connected to ${socket!.remoteAddress.address}");

    socket!.listen(
      (event) {},
      onError: (error) {
        debugPrint("Client: Socket error: $error");

        socket!.destroy();
      },
      onDone: () {
        debugPrint("Client: Socket done");

        socket!.destroy();
      },
    );

    socket!.done.then((value) {
      if (onDisconnect != null) onDisconnect();
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
