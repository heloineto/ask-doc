import 'package:pocketbase/pocketbase.dart';

final client = PocketBase('http://127.0.0.1:8090');

Future<void> register(Map<String, dynamic> request) async {
  final body = <String, dynamic>{
    "name": request["name"],
    "cpf": request["cpf"],
    "birthday": request["birthday"],
    "sex": request["sex"],
    "stats": request["doctor"],
    "password": request["password"]
  };

  try {
    await client.records.create('users', body: body);
  } catch (error) {
    print("Error: Register\n\n${error.toString()}\n\n");

    return;
  }

  print("Success: Register\n\n");
}
