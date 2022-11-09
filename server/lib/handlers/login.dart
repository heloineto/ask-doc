import 'package:pocketbase/pocketbase.dart';

final client = PocketBase('http://127.0.0.1:8090');

Future<void> login(Map<String, dynamic> request) async {
  try {
    final result = await client.records.getList(
      'users',
      page: 1,
      perPage: 1,
      filter:
          'cpf = "${request["cpf"]}" && password = "${request["password"]}"',
    );

    if (result.items.isEmpty) {
      throw ("No user found");
    }

    var rawUser = result.items[0];

    var user = {
      "name": rawUser.getStringValue("name"),
      "cpf": rawUser.getStringValue("cpf"),
      "password": rawUser.getStringValue("password"),
      "birthday": rawUser.getStringValue("birthday"),
      "sex": rawUser.getStringValue("sex"),
      "doctor": rawUser.getBoolValue("doctor"),
    };

    print("\n $user\n");
  } catch (error) {
    print("Error: Login\n\n${error.toString()}\n\n");
    return;
  }

  print("Success: Login\n\n");
}
