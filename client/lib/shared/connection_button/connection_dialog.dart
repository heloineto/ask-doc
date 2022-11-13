import 'package:client/services/client.dart';
import 'package:client/shared/button.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:client/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/shared/text_input.dart';
import 'package:flutter/services.dart' as services;

class ConnectionDialog extends StatefulWidget {
  final void Function(String, int) connect;
  final bool isConnected;

  const ConnectionDialog(
      {super.key, required this.connect, required this.isConnected});

  @override
  State<ConnectionDialog> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  final ip = TextEditingController(text: "127.0.0.1");
  final port = TextEditingController(text: "3000");

  void submit() {
    if (!validateIp(ip.text)) {
      showSnackBar(
        context,
        "Invalid IP Address",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    if (!validatePort(port.text)) {
      showSnackBar(
        context,
        "Invalid Port",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    widget.connect(ip.text, int.parse(port.text));
  }

  void disconnect() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Connection Panel',
        style: TextStyle(
          color: TW3Colors.slate.shade100,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInput(
            label: Text("IP"),
            controller: ip,
          ),
          SizedBox(height: 10),
          TextInput(
            label: Text("Port"),
            controller: port,
            inputFormatters: [services.FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
      actions: [
        Button(
          onPressed: widget.isConnected ? disconnect : null,
          twColor: TW3Colors.red,
          child: Text("Disconnect"),
        ),
        Button(
          onPressed: widget.isConnected ? null : submit,
          child: Text("Connect"),
        ),
      ],
    );
  }
}
