import 'dart:convert';

import 'package:server/inter_client_messages.dart';
import 'package:server/server.dart';
import 'package:server/utils/output.dart';
import 'package:server/utils/pocketbase.dart';

// ignore: prefer_void_to_null
Future<Null> sendChatMessage(Map request) async {
  try {
    final result = await client.records.getList(
      'users',
      page: 1,
      perPage: 1,
      filter: 'cpf = "${request["cpf"]}"',
    );

    if (result.items.isEmpty) {
      throw ("no user found");
    }

    var rawUser = result.items[0];

    String name = rawUser.getStringValue("name");

    sentToCpf(
      toCpf: getReceiverCpf(request["cpf"]),
      message: jsonEncode(
        {
          "code": 106,
          "position": 1,
          "name": name,
          "message": request["message"],
        },
      ),
    );

    return null;
  } catch (error) {
    printError("accept chat request failed $error\n\n");

    return null;
  }
}
