import 'dart:convert';
import 'dart:io';
import 'package:server/handlers.dart';
import 'package:server/utils/input.dart';
import 'package:server/utils/output.dart';

Map<String, Map> clients = {};
List<List<String>> chatConnections = [];

void sendMessage(Socket socket, String message) {
  socket.writeln(message);

  // socket.write(message);
  // socket.write("\n");

  // socket.write("$message\n");
}

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
  String sockedId = '${socket.remoteAddress.address}:${socket.remotePort}';

  clients[sockedId] = {"socket": socket};

  printReady("connection established", id: sockedId);

  socket.listen((event) async {
    print("DEBUG - clients: $clients");
    print("DEBUG - chatConnections: $chatConnections");

    String strRequest = String.fromCharCodes(event);
    printEvent("request: $strRequest", id: sockedId);
    dynamic request;

    try {
      request = jsonDecode(strRequest);
    } catch (error) {
      printError('request was not a json string. error: $error');
      return;
    }

    var response = await chooseHandle(request);

    if (response == null) {
      printError("response is null");
      return;
    }

    if (response["code"] == 103) {
      var client = clients[sockedId];

      if (client == null) {
        printError('unexpected error. clients[sockedId] was null');

        return;
      }

      clients[sockedId] = {...client, "user": response["user"]};
    }

    var strResponse = json.encode(response);

    printEvent("response: $strResponse", id: sockedId);

    sendMessage(socket, strResponse);
  }, onError: (error) {
    printError("socket error: $error", id: sockedId);
    socket.close();
    clients.remove(sockedId);
  }, onDone: () {
    printInfo("socket closed", id: sockedId);
    socket.close();
    clients.remove(sockedId);
  });
}

String getReceiverCpf(String senderCpf) {
  for (int i = 0; i < chatConnections.length; i++) {
    var connection = chatConnections[i];

    if (connection[0] == senderCpf) {
      return connection[1];
    }
    if (connection[1] == senderCpf) {
      return connection[0];
    }
  }

  printError("Couldn't find receiverCpf");
  throw "Couldn't find receiverCpf";
}
