import 'dart:io';
import 'package:client/shared/connection_button/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum ConnectionStatus { connected, loading, disconnected }

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({super.key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {
  ConnectionStatus connectionStatus = ConnectionStatus.disconnected;
  Socket? socket;

  void connect(String ip, int port) async {
    socket = await Socket.connect(ip, port);

    print("connected to ${socket!.remoteAddress.address}");

    setState(() {
      connectionStatus = ConnectionStatus.connected;
    });

    print(socket.toString());

    socket!.handleError((onError) {
      print("SOCKET ERROR");
      setState(() {
        connectionStatus = ConnectionStatus.disconnected;
      });
    });

    socket!.listen(
      (event) {},
      cancelOnError: true,
      onError: (error) {
        print("SOCKET ERROR $error");

        setState(() {
          connectionStatus = ConnectionStatus.disconnected;
        });

        socket!.destroy();
      },
      onDone: () {
        print("SOCKET DONE");

        setState(() {
          connectionStatus = ConnectionStatus.disconnected;
        });

        socket!.destroy();
      },
    );

    socket!.write("Hello World!");
  }

  @override
  Widget build(BuildContext context) {
    bool isConnected = connectionStatus == ConnectionStatus.connected;

    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConnectionDialog(connect: connect),
        );
      },
      tooltip: isConnected ? 'Connect' : 'Disconnect',
      backgroundColor:
          isConnected ? TW3Colors.green.shade500 : TW3Colors.red.shade500,
      child: Icon(
        isConnected ? PhosphorIcons.wifiHighBold : PhosphorIcons.wifiXBold,
        color: Colors.white,
      ),
    );
  }
}
