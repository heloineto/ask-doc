import 'dart:io';
import 'package:server/utils/output.dart';
import 'package:server/utils/validations.dart';

String getIp() {
  print("Insert IP:");
  String? ip = stdin.readLineSync();

  if (ip == null || ip == "") {
    // throw 'No IP provided';
    return "127.0.0.1";
  }
  if (!validateIp(ip)) {
    printError("Error: Invalid IP Address");
    throw 'Invalid IP Address';
    // return;
  }

  return ip;
}

int getPort() {
  print("Insert Port:");
  String? portStr = stdin.readLineSync();

  if (portStr == null || portStr == "") {
    return 3000;
  }
  if (!validatePort(portStr)) {
    printError("Error: Invalid Port");
    throw "Error: Invalid Port";
    // return;
  }

  return int.parse(portStr);
}
