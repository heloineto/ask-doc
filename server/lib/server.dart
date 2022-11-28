import 'dart:convert';
import 'dart:io';
import 'package:server/handlers.dart';
import 'package:server/utils/input.dart';
import 'package:server/utils/output.dart';
import 'package:server/utils/pocketbase.dart';

void run() async {
  // await runPocketbase();
  printLogo();

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

  socket.listen((event) async {
    String strRequest = String.fromCharCodes(event);
    printEvent("request: $strRequest", id: sockedId);

    var request = jsonDecode(strRequest);

    var response = await chooseHandle(request);

    if (response == null) {
      printError("response is null");
      return;
    }

    var strResponse = json.encode(response);

    printEvent("response: $strResponse", id: sockedId);

    socket.writeln(strResponse);
  }, onError: (error) {
    printError("socket error: $error", id: sockedId);
    socket.close();
  }, onDone: () {
    printInfo("socket closed", id: sockedId);
    socket.close();
  });
}
