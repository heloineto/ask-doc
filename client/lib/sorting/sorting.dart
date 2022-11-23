import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:client/sorting/sorting_form.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SortingScreen extends StatelessWidget {
  const SortingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Triagem",
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SortingForm(),
      ),
    );
  }
}
