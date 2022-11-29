import 'package:client/services/client_service.dart';
import 'package:client/shared/app_drawer/app_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Ask Doc'),
          ),
          AppListTile(
            title: 'Casa',
            icon: PhosphorIcons.houseFill,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          AppListTile(
            title: "Triagem",
            icon: PhosphorIcons.heartbeatFill,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sorting');
            },
          ),
          AppListTile(
            title: "Pedir Paciente",
            icon: PhosphorIcons.usersThreeFill,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/doctor_queue');
            },
          ),
          AppListTile(
            title: 'Logout',
            icon: PhosphorIcons.signOutFill,
            textColor: TW3Colors.red,
            onTap: () {
              clientService.logout();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
