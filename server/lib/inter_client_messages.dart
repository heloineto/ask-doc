import 'dart:io';
import 'package:server/server.dart';
import 'package:server/utils/output.dart';

String? getSockedId({required String cpf}) {
  String? clientId;

  clients.forEach((key, value) {
    if (value["user"] == null) {
      return;
    }

    if (value["user"]["cpf"] == cpf) {
      clientId = key;
    }
  });

  return clientId;
}

bool sentToCpf({
  required String toCpf,
  required String message,
}) {
  String? toSockedId = getSockedId(cpf: toCpf);

  if (toSockedId == null) {
    printError("client with cpf $toCpf is offline or doesn't exist");
    return false;
  }

  var toClient = clients[toSockedId];
  Socket? toSocket = toClient?["socket"];

  if (toSocket == null) {
    printError("unexpected error, toSocket is null");
    return false;
  }

  sendMessage(toSocket, message);
  return true;
}
