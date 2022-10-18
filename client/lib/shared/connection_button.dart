import 'dart:io';
import 'package:flutter/material.dart';

class ConnectionButton extends StatelessWidget {
  const ConnectionButton({super.key});

  void connect() async {
    String ip = "127.0.0.1";
    int port = 3000;

    Socket socket = await Socket.connect(ip, port);
    print("connected to ${socket.remoteAddress.address}");

    print(socket.toString());
    // socket.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: connect,
      tooltip: 'Increment',
      child: Icon(Icons.wifi_off),
    );
  }
}
