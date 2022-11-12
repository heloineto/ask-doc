import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ConnectionDialog extends StatelessWidget {
  const ConnectionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Connection Panel',
        style: TextStyle(
          color: TW3Colors.slate.shade100,
        ),
      ),
      content: Container(),
      actions: [Button(onPressed: () {}, child: Text("Connect"))],
    );
  }
}
