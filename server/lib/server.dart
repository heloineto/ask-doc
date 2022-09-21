import 'dart:io';

void run() async {
  String ip = "";
  int port = 1;

  Socket socket = await Socket.connect(ip, port);

  socket.listen((event) {});
}
