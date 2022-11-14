import 'package:pocketbase/pocketbase.dart';
import 'package:server/utils/output.dart';

final client = PocketBase('http://127.0.0.1:8090');

Future<Map> register(Map request) async {
  final body = <String, dynamic>{
    "name": request["name"],
    "cpf": request["cpf"],
    "birthday": request["birthday"],
    "sex": request["sex"],
    "stats": request["stats"],
    "password": request["password"]
  };

  print("body: $body");

  try {
    await client.records.create('users', body: body);

    return {
      "code": 101,
      "success": true,
    };
  } catch (error) {
    printError("register failed $error\n\n");

    return {
      "code": 101,
      "success": false,
    };
  }
}
