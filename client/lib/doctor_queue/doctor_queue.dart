import 'dart:convert';

import 'package:client/services/client_service.dart';
import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DoctorQueueScreen extends StatefulWidget {
  const DoctorQueueScreen({super.key});

  @override
  State<DoctorQueueScreen> createState() => _DoctorQueueScreenState();
}

class _DoctorQueueScreenState extends State<DoctorQueueScreen> {
  dynamic response;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Pacientes",
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Button(
              child: Text("Próximo"),
              onPressed: () {
                Provider.of<ClientService>(context, listen: false)
                    .nextPatient((currentResponse) {
                  setState(() {
                    response = currentResponse;
                  });
                });
              },
            ),
            Text("Response:"),
            Text(jsonEncode(response))
          ],
        ),
      ),
    );
  }
}
