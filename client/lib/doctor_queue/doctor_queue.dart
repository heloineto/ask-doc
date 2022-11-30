import 'dart:convert';

import 'package:client/doctor_queue/patient.dart';
import 'package:client/services/client_service.dart';
import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:client/shared/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

String prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

class DoctorQueueScreen extends StatefulWidget {
  const DoctorQueueScreen({super.key});

  @override
  State<DoctorQueueScreen> createState() => _DoctorQueueScreenState();
}

class _DoctorQueueScreenState extends State<DoctorQueueScreen> {
  dynamic response = {};

  @override
  Widget build(BuildContext context) {
    var jsonStr = prettyJson(response);

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
            SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                color: TW3Colors.zinc.shade900,
                border: Border.all(
                  color: TW3Colors.zinc.shade700,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                jsonStr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // if (response != null)
            //   response["success"] == false
            //       ? Column(
            //           children: [
            //             Icon(
            //               PhosphorIcons.xCircle,
            //               size: 60,
            //               color: TW3Colors.zinc.shade300,
            //             ),
            //             SizedBox(height: 8),
            //             Text(
            //               "Nenhum paciente encontrado",
            //               style: TextStyle(
            //                 color: TW3Colors.zinc.shade200,
            //                 fontSize: 18,
            //               ),
            //             )
            //           ],
            //         )
            //       : Patient(patient: response["user"])
          ],
        ),
      ),
    );
  }
}
