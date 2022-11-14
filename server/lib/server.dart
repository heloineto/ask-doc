import 'dart:convert';
import 'dart:io';
import 'package:server/handlers.dart';
import 'package:server/utils/input.dart';
import 'package:server/utils/output.dart';
import 'package:server/utils/pocketbase.dart';

void run() async {
  await runPocketbase();

  String ip = getIp();
  int port = getPort();

  final server = await ServerSocket.bind(ip, port);
  printReady("started server on $ip:$port");

  server.listen((Socket socket) {
    handleConnection(socket);
  });
}

void handleConnection(Socket socket) {
  String sockedId = '${socket.remoteAddress.address}:${socket.port}';

  printReady("connection established", id: sockedId);

  socket.listen((event) {
    String strEvent = String.fromCharCodes(event);
    printEvent("received: $strEvent", id: sockedId);

    var request = jsonDecode(strEvent);

    chooseHandle(request);
  }, onError: (error) {
    printError("socket error: $error", id: sockedId);
    socket.close();
  }, onDone: () {
    printInfo("socket closed", id: sockedId);
    socket.close();
  });
}
