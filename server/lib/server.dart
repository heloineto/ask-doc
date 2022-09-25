import 'dart:io';

void run() async {
  String ip = "127.0.0.1";
  int port = 8000;

  Socket socket = await Socket.connect(ip, port);

  print(socket.toString());

  socket.listen((event) {});
}
