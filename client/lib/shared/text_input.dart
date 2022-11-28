import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final Widget? label;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? initialValue;

  const TextInput({
    super.key,
    this.label,
    this.onChanged,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.maxLines,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: label,
      ),
      style: TextStyle(
        color: Colors.white,
      ),
      controller: controller,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      initialValue: initialValue,
    );
  }
}
