import 'package:client/services/client.dart';
import 'package:client/shared/connection_button/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:provider/provider.dart';

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({super.key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  ConnectionStatus status = ConnectionStatus.disconnected;

  void connect(String ip, int port) async {
    context.read<Client>().connect(
          ip: ip,
          port: port,
          onConnect: () => setState(
            () => status = ConnectionStatus.connected,
          ),
          onDisconnect: () => setState(
            () => status = ConnectionStatus.disconnected,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isConnected = false;
    // Provider.of<Client>(context).status == ConnectionStatus.connected;

    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConnectionDialog(
            connect: connect,
            isConnected: isConnected,
          ),
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
