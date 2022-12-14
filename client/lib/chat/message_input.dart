import 'package:client/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(PhosphorIcons.paperPlaneRightFill),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              clientService.sendChatMessage(
                message: message,
              );
            },
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) => setState(() => message = value),
              decoration: InputDecoration(
                hintText: 'Send a message...',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 60)
        ],
      ),
    );
  }
}
