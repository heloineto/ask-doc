import 'dart:io';
import 'package:server/utils/output.dart';
import 'package:server/utils/validations.dart';

String getIp() {
  print("Insert IP:");
  String? ip = stdin.readLineSync();

  if (ip == null || ip == "") {
    throw 'No IP provided';
  }
  if (!validateIp(ip)) {
    printError("Error: Invalid IP Address");
    throw 'Invalid IP Address';
  }

  return ip;
}

int getPort() {
  print("Insert Port:");
  String? portStr = stdin.readLineSync();

  if (portStr == null || portStr == "") {
    throw 'No Port provided';
  }
  if (!validatePort(portStr)) {
    printError("Error: Invalid Port");
    throw "Error: Invalid Port";
  }

  return int.parse(portStr);
}
