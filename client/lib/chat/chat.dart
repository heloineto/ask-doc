import 'package:client/chat/message_input.dart';
import 'package:client/services/client_service.dart';
import 'package:client/shared/app_scaffold.dart';
import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> chat = Provider.of<ClientService>(context, listen: true).chat;

    return AppScaffold(
      title: "Chat",
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Conversando com:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Button(
                  width: 250,
                  twColor: TW3Colors.red,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(PhosphorIcons.xCircle),
                      SizedBox(width: 10),
                      Text(
                        'Sair do chat',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: TW3Colors.zinc.shade800,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: chat.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = chat[chat.length - index - 1];

                      return Column(
                        crossAxisAlignment: item["isMe"]
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Bubble(
                            padding: BubbleEdges.all(15),
                            margin: BubbleEdges.only(top: 10),
                            nip: item["isMe"]
                                ? BubbleNip.leftTop
                                : BubbleNip.rightTop,
                            color: item["isMe"]
                                ? Colors.white
                                : Color.fromARGB(255, 225, 255, 199),
                            child: Text(
                              item["message"],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 10)
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            MessageInput(),
          ],
        ),
      ),
    );
  }
}
