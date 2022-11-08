import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final DateFormat format = DateFormat('dd/MM/yyyy');
  final Widget? label;
  final String? hintText;
  final void Function(DateTime?)? onSaved;
  final String? Function(DateTime?)? validator;

  DateField({
    super.key,
    required this.label,
    this.hintText,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: format,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        label: label,
      ),
      style: TextStyle(
        color: Colors.white,
      ),
      onShowPicker: (context, value) async {
        final date = showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        return date;
      },
      validator: validator,
      onSaved: onSaved,
    );
  }
}
