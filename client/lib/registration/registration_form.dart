import 'package:client/services/client_service.dart';
import 'package:client/utils/show_snack_bar.dart';
import "package:flutter/material.dart";
import 'package:client/shared/date_Field.dart';
import 'package:client/shared/dropdown_field.dart';
import 'package:client/shared/text_input.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

String dateToString(DateTime date) {
  final DateFormat formatter = DateFormat('ddMMyyyy');

  return formatter.format(date);
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final name = TextEditingController();
  final cpf = TextEditingController();
  final password = TextEditingController();
  DateTime? birthday;
  String? sex;
  String? statsString;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onSubmit() {
    FormState formState = _formKey.currentState!;

    if (!formState.validate()) {
      return;
    }

    formState.save();

    context.read<ClientService>().register(
        name: name.text,
        cpf: cpf.text,
        password: password.text,
        birthday: dateToString(birthday!),
        sex: sex!,
        stats: statsString == "Medico");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextInput(
            controller: name,
            label: Text("Nome"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }

              return null;
            },
          ),
          SizedBox(height: 25),
          TextInput(
            controller: cpf,
            label: Text("CPF"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }

              return null;
            },
          ),
          SizedBox(height: 25),
          TextInput(
            controller: password,
            label: Text("Senha"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }

              return null;
            },
          ),
          SizedBox(height: 25),
          DropdownField(
            items: ["Masculino", "Feminino", "Outros"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            label: Text("Sexo"),
            onSaved: (value) => sex = value,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }

              return null;
            },
          ),
          SizedBox(height: 25),
          DropdownField(
            items: ["Medico", "Paciente"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            label: Text("Status"),
            onSaved: (value) => statsString = value,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }

              return null;
            },
          ),
          SizedBox(height: 25),
          DateField(
            label: Text("Nascimento"),
            onSaved: (value) => birthday = value,
            validator: (DateTime? value) {
              if (value == null) {
                return 'Campo obrigatório';
              }

              return null;
            },
          ),
          SizedBox(height: 25),
          SizedBox(
            height: 52,
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.white;
                  },
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return TW3Colors.emerald;
                  },
                ),
              ),
              onPressed: () {
                onSubmit();
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
        ],
      ),
    );
  }
}
