import 'package:client/services/client_service.dart';
import 'package:client/shared/connection_button/connection_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, this.title, this.body});

  final String? title;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context);

    return Scaffold(
      floatingActionButton: ConnectionButton(),
      appBar: AppBar(title: Text(title ?? "Ask Doc")),
      body: body,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Ask Doc'),
            ),
            ListTile(
              title: const Text('Casa', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title:
                  const Text('Triagem', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sorting');
              },
            ),
            ListTile(
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                clientService.logout();
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
