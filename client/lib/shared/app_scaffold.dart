import 'package:client/shared/app_drawer/app_drawer.dart';
import 'package:client/shared/connection_button/connection_button.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, this.title, this.body});

  final String? title;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ConnectionButton(),
      appBar: AppBar(title: Text(title ?? "Ask Doc")),
      body: body,
      drawer: AppDrawer(),
    );
  }
}
