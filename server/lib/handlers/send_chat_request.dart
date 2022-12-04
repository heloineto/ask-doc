import 'package:server/utils/pocketbase.dart';
import 'package:server/utils/output.dart';

Future<Map> sendChatRequest(Map request) async {
  final body = <String, dynamic>{
    "cpf": request["cpf"],
    "description": request["description"],
    "priority": request["priority"],
    "oudated": false,
  };

  try {
    await client.records.create('sorting', body: body);

    return {
      "code": 109,
      "success": true,
    };
  } catch (error) {
    printError("sorting failed $error\n\n");

    return {
      "code": 109,
      "success": false,
    };
  }
}
