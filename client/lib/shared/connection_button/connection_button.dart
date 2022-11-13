import 'package:client/services/client_service.dart';
import 'package:client/shared/connection_button/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:provider/provider.dart';

class ConnectionButton extends StatelessWidget {
  const ConnectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    bool isConnected =
        context.watch<ClientService>().status == ConnectionStatus.connected;

    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConnectionDialog(),
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
