import 'package:server/utils/output.dart';
import 'package:pocketbase/pocketbase.dart';

final client = PocketBase('http://127.0.0.1:8090');

Future<Map> login(Map request) async {
  try {
    final result = await client.records.getList(
      'users',
      page: 1,
      perPage: 1,
      filter:
          'cpf = "${request["cpf"]}" && password = "${request["password"]}"',
    );

    if (result.items.isEmpty) {
      throw ("no user found");
    }

    var rawUser = result.items[0];

    var user = {
      "name": rawUser.getStringValue("name"),
      "cpf": rawUser.getStringValue("cpf"),
      "birthday": rawUser.getStringValue("birthday"),
      "sex": rawUser.getStringValue("sex"),
      "doctor": rawUser.getBoolValue("doctor"),
    };

    return {
      "code": 103,
      "status": true,
      "user": user,
    };
  } catch (error) {
    printError("login failed $error\n\n");
    return {
      "code": 103,
      "status": false,
    };
  }
}
