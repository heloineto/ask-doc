import 'dart:convert';
import 'dart:io';
import 'package:server/handlers.dart';
import 'package:server/utils/print.dart';
import 'package:server/utils/validations.dart';

void run() async {
  print("Insert IP");
  String? ip = stdin.readLineSync();

  // final ip = "127.0.0.1";
  // int port = 3000;

  if (ip == null || ip == "") {
    return;
  }
  if (!validateIp(ip)) {
    printError("Error: Invalid Ip Address");
    return;
  }

  print("Port");
  String? portStr = stdin.readLineSync();

  if (portStr == null || portStr == "") {
    return;
  }
  if (!validatePort(portStr)) {
    printError("Error: Invalid Port");
    return;
  }

  int port = int.parse(portStr);

  final server = await ServerSocket.bind(ip, port);
  printSuccess("Running on $ip:$portStr");

  server.listen((Socket socket) {
    handleConnection(socket);
  });
}

void chooseHandle(dynamic request) {
  int? code = request["code"] as int?;

  if (code == null) {
    printError("Error: no code was provided");
    return;
  }

  Function? handler = handlers[code];

  if (handler == null) {
    printError("Error: unknown code provided");
    return;
  }

  handler(request);
}

void handleConnection(Socket socket) {
  String sockedId = '${socket.remoteAddress.address}:${socket.remotePort}';

  printSuccess("Connection Established ($sockedId)");

  socket.listen((event) {
    String strEvent = String.fromCharCodes(event);
    printInfo("Received event: $strEvent");

    var request = jsonDecode(strEvent);

    chooseHandle(request);
  }, onError: (error) {
    printError("Socket Error: $error ($sockedId)");
    socket.close();
  }, onDone: () {
    print("Socket closed ($sockedId)");
    socket.close();
  });
}
