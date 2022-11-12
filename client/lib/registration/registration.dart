import 'package:client/shared/date_Field.dart';
import 'package:client/shared/dropdown_field.dart';
import 'package:client/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/shared/main_scaffold.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Container(
        color: TW3Colors.zinc.shade900,
        child: Center(
          child: Container(
            width: 600,
            height: 700,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: TW3Colors.zinc.shade700,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                TextInput(
                  label: Text("Nome"),
                ),
                SizedBox(height: 25),
                TextInput(
                  label: Text("CPF"),
                ),
                SizedBox(height: 25),
                TextInput(
                  label: Text("Senha"),
                ),
                SizedBox(height: 25),
                DropdownField(
                  items: ["Maculino", "Feminino", "Outros"]
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  label: Text("Sexo"),
                ),
                SizedBox(height: 25),
                DropdownField(
                  items: ["Medico", "Paciente"]
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  label: Text("Status"),
                ),
                SizedBox(height: 25),
                DateField(label: Text("Nascimento")),
                SizedBox(height: 25),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.white;
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return TW3Colors.emerald;
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                Divider(height: 70),
                SizedBox(
                  height: 52,
                  width: 250,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.white;
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return TW3Colors.blue;
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text(
                      'Voltar',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
