import 'package:client/shared/button.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:client/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/shared/text_input.dart';
import 'package:flutter/services.dart' as services;

class ConnectionDialog extends StatefulWidget {
  final void Function(String, int) connect;

  const ConnectionDialog({super.key, required this.connect});

  @override
  State<ConnectionDialog> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  String ip = "";
  String port = "";

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
          TextInput(label: Text("IP"), onChanged: (value) => ip = value),
          SizedBox(height: 10),
          TextInput(
            label: Text("Port"),
            onChanged: (value) => port = value,
            inputFormatters: [services.FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
      actions: [
        Button(
          onPressed: () {},
          twColor: TW3Colors.red,
          child: Text("Disconnect"),
        ),
        Button(
          onPressed: () {
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

            widget.connect(ip, int.parse(port));
          },
          child: Text("Connect"),
        ),
      ],
    );
  }
}
