import 'package:client/services/response_handlers/receive_chat_request.dart';
import 'package:client/services/response_handlers/sent_chat_request.dart';
import './login.dart';
import './logout.dart';
import './register.dart';
import './sorting.dart';
import './patient_queue.dart';
import './next_patient.dart';

var responseHandlers = {
  103: login,
  101: register,
  114: logout,
  109: sorting,
  110: patientQueue,
  118: nextPatient,
  105: sendChatRequest,
  1005: receiveChatRequest,
};
