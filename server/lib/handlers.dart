import 'package:server/handlers/register.dart';
import 'package:server/handlers/login.dart';
import 'package:server/utils/output.dart';

var handlers = {
  1: register,
  2: login,
};

void chooseHandle(dynamic request) {
  int? code = request["code"] as int?;

  if (code == null) {
    printError("no code was provided");
    return;
  }

  Function? handler = handlers[code];

  if (handler == null) {
    printError("unknown code provided");
    return;
  }

  handler(request);
}
