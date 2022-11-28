import 'package:server/utils/output.dart';
import 'package:server/utils/pocketbase.dart';

Future<Map> patientQueue(Map request) async {
  try {
    final result = await client.records.getList(
      'sorting',
      page: 1,
      perPage: 999,
      sort: 'priority, created',
    );

    if (result.items.isEmpty) {
      throw ("queue is empty");
    }

    var items = result.items;
    var length = items.length;
    var i = 0;

    while (items[i].getStringValue("cpf") != request['cpf'] && i < length) {
      i++;
    }
    i++;

    return {
      "code": 110,
      "position": i,
    };
  } catch (error) {
    printError("Next patient request failed $error\n\n");
    return {
      "code": 110,
      "succsess": false,
    };
  }
}
