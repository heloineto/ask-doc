import 'package:client/shared/connection_button/connection_button.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget? body;

  const MainScaffold({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: ConnectionButton(),
    );
  }
}
