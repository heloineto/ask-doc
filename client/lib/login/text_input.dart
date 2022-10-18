import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Widget? label;

  const TextInput({super.key, this.label});

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
    );
  }
}
