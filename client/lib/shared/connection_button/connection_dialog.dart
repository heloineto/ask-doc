import 'package:client/services/client_service.dart';
import 'package:client/shared/button.dart';
import 'package:client/shared/text_icon_button.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:client/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/shared/text_input.dart';
import 'package:flutter/services.dart' as services;

class ConnectionDialog extends StatefulWidget {
  const ConnectionDialog({super.key});

  @override
  State<ConnectionDialog> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  String ip = '';
  String port = '';

  void submit() {
    if (ip == '' && port == '') {
      ip = '127.0.0.1';
      port = '21000';
    }

    if (!validateIp(ip)) {
      showSnackBar(
        context,
        "Invalid IP Address",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    if (!validatePort(port)) {
      showSnackBar(
        context,
        "Invalid Port",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    context.read<ClientService>().connect(
          ip: ip,
          port: int.parse(port),
        );

    Navigator.pop(context);
  }

  void disconnect() {
    context.read<ClientService>().disconnect();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isConnected =
        context.watch<ClientService>().status == ConnectionStatus.connected;

    return AlertDialog(
      title: Text(
        'Painel de Conexão',
        style: TextStyle(color: TW3Colors.slate.shade100),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInput(
            label: Text("IP"),
            initialValue: ip,
            onChanged: (value) => ip = value,
          ),
          SizedBox(height: 10),
          TextInput(
            label: Text("Port"),
            initialValue: port,
            onChanged: (value) => port = value,
            inputFormatters: [services.FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox(height: 20),
          isConnected
              ? TextIconButton(
                  onPressed: disconnect,
                  twColor: TW3Colors.red,
                  icon: PhosphorIcons.wifiSlash,
                  text: 'Desconectar',
                )
              : TextIconButton(
                  onPressed: submit,
                  icon: PhosphorIcons.wifiHigh,
                  text: 'Conectar',
                ),
        ],
      ),
    );
  }
}
