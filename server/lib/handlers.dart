import 'package:server/handlers/accept_chat_request.dart';
import 'package:server/handlers/logout.dart';
import 'package:server/handlers/patient_queue.dart';
import 'package:server/handlers/register.dart';
import 'package:server/handlers/login.dart';
import 'package:server/handlers/send_chat_message.dart';
import 'package:server/handlers/send_chat_request.dart';
import 'package:server/handlers/sorting.dart';
import 'package:server/handlers/next_patient.dart';
import 'package:server/utils/output.dart';

var handlers = {
  1: register,
  3: login,
  5: sendChatRequest,
  6: sendChatMessage,
  9: sorting,
  10: patientQueue,
  12: acceptChatRequest,
  14: logout,
  18: nextPatient,
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
