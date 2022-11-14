import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?)? validator;
  final Widget? label;
  final String? hintText;

  const DropdownField({
    super.key,
    this.onSaved,
    required this.items,
    this.validator,
    this.label,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        label: label,
      ),
      style: TextStyle(color: Colors.white),
      items: items,
      onChanged: (_) {},
      validator: validator,
      onSaved: onSaved,
    );
  }
}
