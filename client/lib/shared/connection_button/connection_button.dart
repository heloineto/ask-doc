import 'dart:io';
import 'package:client/services/Client.dart';
import 'package:client/shared/connection_button/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:provider/provider.dart';

enum ConnectionStatus { connected, loading, disconnected }

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({super.key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  ConnectionStatus connectionStatus = ConnectionStatus.disconnected;

  void connect(String ip, int port) async {
    context.read<Client>().connect(
          ip: ip,
          port: port,
          onConnect: () => setState(
            () => connectionStatus = ConnectionStatus.connected,
          ),
          onDisconnect: () => setState(
            () => connectionStatus = ConnectionStatus.disconnected,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isConnected = connectionStatus == ConnectionStatus.connected;

    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConnectionDialog(connect: connect),
        );
      },
      tooltip: isConnected ? 'Connect' : 'Disconnect',
      backgroundColor:
          isConnected ? TW3Colors.green.shade500 : TW3Colors.red.shade500,
      child: Icon(
        isConnected ? PhosphorIcons.wifiHighBold : PhosphorIcons.wifiXBold,
        color: Colors.white,
      ),
    );
  }
}
