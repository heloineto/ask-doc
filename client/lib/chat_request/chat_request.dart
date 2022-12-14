import 'package:client/services/client_service.dart';
import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ChatRequestScreen extends StatelessWidget {
  const ChatRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Pedido de Chat",
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              width: 250,
              twColor: TW3Colors.red,
              onPressed: () {
                var clientService = Provider.of<ClientService>(
                  context,
                  listen: false,
                );
                clientService.rejectChatRequest();
                Navigator.pushNamed(context, '/home');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(PhosphorIcons.xCircle),
                  SizedBox(width: 10),
                  Text(
                    'Rejeitar',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(width: 20),
            Button(
              width: 250,
              twColor: TW3Colors.emerald,
              onPressed: () {
                var clientService = Provider.of<ClientService>(
                  context,
                  listen: false,
                );
                clientService.acceptChatRequest();
                Navigator.pushNamed(context, '/chat');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(PhosphorIcons.checkCircle),
                  SizedBox(width: 10),
                  Text(
                    'Aceitar',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
