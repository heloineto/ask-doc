import 'package:client/registration/registration_form.dart';
import 'package:client/shared/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

const defaultPatient = {
  "name": "João Victor",
  "cpf": "00011100011",
  "birthday": "11112022",
  "sex": "M",
  "description": "Headache",
  "priority": 1
};

final DateFormat formatter = DateFormat('ddMMyyyy');

class Patient extends StatelessWidget {
  final Map patient;

  const Patient({super.key, this.patient = defaultPatient});

  DateTime? stringToDate(String str) {
    try {
      return formatter.parseLoose(str);
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? birthday = stringToDate(patient["birthday"]);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: TW3Colors.zinc.shade400,
              ),
              child: Icon(PhosphorIcons.userFill, size: 90),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient["name"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  patient["cpf"],
                  style: TextStyle(
                    color: TW3Colors.zinc.shade300,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(birthday.toString()),
            if (birthday != null)
              DateField(
                label: Text("Nascimento"),
                initialValue: birthday,
              )
          ],
        )
      ],
    );
  }
}
