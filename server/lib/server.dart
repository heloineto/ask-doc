import 'dart:io';

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

void handleConnection(Socket socket) {
  print("handleConnection");

  socket.listen((event) {
    final String json = String.fromCharCodes(event);
    print(json);
  }, onError: (error) {
    print(error);
    socket.close();
  }, onDone: () {
    print("[INFO]: Socket closed");
    socket.close();
  });
}
