import 'dart:convert';

import 'package:server/inter_client_messages.dart';
import 'package:server/server.dart';
import 'package:server/utils/output.dart';

Future<Map> acceptChatRequest(Map request) async {
  try {
    bool success = sentToCpf(
      toCpf: getReceiverCpf(request["cpf"]),
      message: jsonEncode(
        {
          "code": 212,
          "success": true,
        },
      ),
    );

    return {
      "code": 112,
      "success": success,
    };
  } catch (error) {
    printError("accept chat request failed $error\n\n");

    return {
      "code": 112,
      "success": false,
    };
  }
}
