import 'dart:io';
import 'dart:convert';
import 'package:server/handlers/register.dart';
import 'package:server/handlers/login.dart';
import 'dart:io';
import 'dart:typed_data';

var request = {
  "code": 2,
  "name": "João Victor",
  "cpf": "00011100011",
  "password": "123456",
  "birthday": "00110000",
  "sex": "M",
  "doctor": true
};

var handlers = {
  1: register,
  2: login,
};

void run() async {
  final ip = "127.0.0.1";
  int port = 3000;

  final server = await ServerSocket.bind(ip, port);
  print("Server is running on $ip:${port.toString()}");

  server.listen((Socket socket) {
    handleConnection(socket);
  });
}

List<Socket> clients = [];

void chooseHandle() {
  int? code = request["code"] as int?;

  if (code == null) {
    // Error: no code was provided
    return;
  }

  Function? handler = handlers[code];

  if (handler == null) {
    // Error: unknown code provided
    return;
  }

  handler(request);
}

void handleConnection(Socket socket) {
  print(
    "Server: Connection from ${socket.remoteAddress.address}:${socket.remotePort}",
  );

  socket.listen((event) {
    String str = String.fromCharCodes(event);
    print("Recieved $str");
    //  request = jsonDecode(json);
  }, onError: (error) {
    print(error);
    socket.close();
  }, onDone: () {
    print("[INFO]: Socket closed");
    socket.close();
  });
}
