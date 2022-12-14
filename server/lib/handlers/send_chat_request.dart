import 'dart:convert';

import 'package:server/inter_client_messages.dart';
import 'package:server/server.dart';
import 'package:server/utils/output.dart';

Future<Map> sendChatRequest(Map request) async {
  try {
    bool success = sentToCpf(
      toCpf: request["toCpf"],
      message: jsonEncode(
        {
          "code": 155,
          "success": true,
        },
      ),
    );

    chatConnections.add([request["toCpf"], request["fromCpf"]]);

    return {
      "code": 105,
      "success": success,
    };
  } catch (error) {
    printError("send chat request failed $error\n\n");

    return {
      "code": 105,
      "success": false,
    };
  }
}
