import 'package:server/utils/output.dart';
import 'package:server/utils/pocketbase.dart';

Future<Map> nextPatient(Map request) async {
  try {
    final sortingResult = await client.records.getList(
      'sorting',
      page: 1,
      perPage: 1,
      filter: 'outdated != true',
      sort: 'priority, created',
    );

    if (sortingResult.items.isEmpty) {
      throw ("queue is empty");
    }

    var sortingItem = sortingResult.items[0];

    final usersResult = await client.records.getList(
      'users',
      page: 1,
      perPage: 1,
      filter: 'cpf = "${sortingItem.getStringValue("cpf")}"',
    );

    if (usersResult.items.isEmpty) {
      throw ("no patient found");
    }

    var userItem = usersResult.items[0];

    var user = {
      "name": userItem.getStringValue("name"),
      "cpf": sortingItem.getStringValue("cpf"),
      "birthday": userItem.getStringValue("birthday"),
      "sex": userItem.getStringValue("sex"),
      "description": sortingItem.getStringValue("description"),
      "priority": sortingItem.getIntValue("priority"),
    };

    await client.records.update(
      'sorting',
      sortingItem.id,
      body: {
        "outdated": true,
      },
    );

    return {
      "code": 118,
      "succsess": true,
      "user": user,
    };
  } catch (error) {
    printError("Next patient request failed $error\n\n");
    return {
      "code": 118,
      "succsess": false,
    };
  }
}
