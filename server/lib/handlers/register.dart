import 'package:server/utils/output.dart';
import 'package:server/utils/pocketbase.dart';

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
