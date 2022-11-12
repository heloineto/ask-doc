import 'dart:io';
import 'package:client/shared/button.dart';
import 'package:client/shared/connection_button/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum ConnectionStatus { connected, loading, disconnected }

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({super.key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  ConnectionStatus connectionStatus = ConnectionStatus.disconnected;

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
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConnectionDialog(),
        );
      },
      tooltip: 'Increment',
      backgroundColor: TW3Colors.red.shade500,
      child: Icon(
        PhosphorIcons.wifiXBold,
        color: Colors.white,
      ),
    );
  }
}
