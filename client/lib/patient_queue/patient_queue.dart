import 'dart:convert';

import 'package:client/services/client_service.dart';
import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PatientQueueScreen extends StatefulWidget {
  const PatientQueueScreen({super.key});

  @override
  State<PatientQueueScreen> createState() => _PatientQueueScreenState();
}

class _PatientQueueScreenState extends State<PatientQueueScreen> {
  dynamic response;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Fila",
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Button(
              child: Text("Atualizar"),
              onPressed: () {
                Provider.of<ClientService>(context, listen: false)
                    .patientQueue((currentResponse) {
                  setState(() {
                    response = currentResponse;
                  });
                });
              },
            ),
            Text("Posição:"),
            Text(jsonEncode(response))
          ],
        ),
      ),
    );
  }
}
