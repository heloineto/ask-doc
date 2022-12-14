import 'package:client/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ConnectionConsole extends StatelessWidget {
  const ConnectionConsole({super.key});

  @override
  Widget build(BuildContext context) {
    List<Text> logs = Provider.of<ClientService>(context, listen: false).logs;

    return Container(
      height: 300,
      width: 400,
      decoration: BoxDecoration(
        color: TW3Colors.zinc.shade600,
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: logs,
          ),
        ),
      ),
    );
  }
}
