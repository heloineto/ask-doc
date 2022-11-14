import 'package:server/handlers/register.dart';
import 'package:server/handlers/login.dart';
import 'package:server/utils/output.dart';

var handlers = {
  1: register,
  3: login,
};

Future<Map?> chooseHandle(dynamic request) async {
  int? code = request["code"] as int?;

  if (code == null) {
    printError("no code was provided");
    return null;
  }

  var handler = handlers[code];

  if (handler == null) {
    printError("unknown code provided");
    return null;
  }

  var response = await handler(request);

  return response;
}
