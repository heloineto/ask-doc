import 'package:server/utils/output.dart';
import 'package:pocketbase/pocketbase.dart';

final client = PocketBase('http://127.0.0.1:8090');

Future<Map> logout(Map request) async {
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

    return {
      "code": 114,
      "success": true,
    };
  } catch (error) {
    printError("login failed $error\n\n");
    return {
      "code": 114,
      "success": false,
    };
  }
}
