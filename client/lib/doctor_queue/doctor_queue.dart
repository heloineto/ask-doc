import 'dart:convert';

import 'package:client/services/client_service.dart';
import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:client/shared/text_icon_button.dart';
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
            TextIconButton(
              icon: PhosphorIcons.arrowCircleRight,
              text: "Pedir próximo paciente",
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
            Text(jsonEncode(response)),
            if (response != null)
              response["success"] == false
                  ? Column(
                      children: [
                        Icon(
                          PhosphorIcons.xCircle,
                          size: 60,
                          color: TW3Colors.zinc.shade300,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Nenhum paciente encontrado",
                          style: TextStyle(
                            color: TW3Colors.zinc.shade200,
                            fontSize: 18,
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [],
                    )
          ],
        ),
      ),
    );
  }
}
