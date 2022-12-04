import 'package:client/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/utils/show_snack_bar.dart';
import 'package:client/services/client_service.dart';
import 'package:provider/provider.dart';

class SortingForm extends StatefulWidget {
  const SortingForm({super.key});

  @override
  State<SortingForm> createState() => _SortingFormState();
}

class _SortingFormState extends State<SortingForm> {
  final description = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _currentSliderValue = 1;

  void onSubmit() {
    FormState formState = _formKey.currentState!;

    if (!formState.validate()) {
      showSnackBar(context, "Form Invalid");
      return;
    }

    formState.save();

    context.read<ClientService>().sorting(
          description: description.text,
          priority: _currentSliderValue.round(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
            controller: description,
            label: Text("Descriçao"),
            maxLines: 10,
          ),
          SizedBox(height: 25),
          Text(
            "Prioridade",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
          ),
          Slider(
            value: _currentSliderValue,
            max: 5,
            min: 1,
            divisions: 4,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
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
                // Navigator.pushNamed(context, '/home');
              },
              child: Text(
                'Enviar',
                style: TextStyle(
                  fontSize: 28,
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
