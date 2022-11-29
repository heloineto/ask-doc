import 'dart:io';
import 'package:server/utils/output.dart';
import 'package:server/utils/validations.dart';

final defaultIp = '127.0.0.1';
final defaultPort = '21000';

String getIp() {
  print("Insert IP:");
  String? ip = stdin.readLineSync();

  if (ip == null || ip == "") {
    print("No IP provided, using $defaultIp");
    return defaultIp;
    // throw 'No IP provided';
  }
  if (!validateIp(ip)) {
    printError("invalid IP address");
    throw 'invalid IP address';
  }

  return ip;
}

int getPort() {
  print("Insert Port:");
  String? portStr = stdin.readLineSync();

  if (portStr == null || portStr == "") {
    print("No port provided, using $defaultPort");
    return int.parse(defaultPort);
    // throw 'no port provided';
  }
  if (!validatePort(portStr)) {
    printError("invalid port");
    throw "invalid port";
  }

  return int.parse(portStr);
}
