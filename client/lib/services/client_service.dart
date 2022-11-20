import 'dart:io';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'dart:convert';

enum ConnectionStatus { connected, loading, disconnected }

var user;

void login(
  request, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!request["status"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "Credenciais erradas",
      backgroundColor: TW3Colors.red.shade500,
    );

    return;
  }

  var navigatorState = navigatorKey.currentState;

  if (navigatorState == null) {
    showSnackBarWithKey(
      scaffoldKey,
      "navigatorState é null",
      backgroundColor: TW3Colors.red.shade500,
    );
    return;
  }

  navigatorState.pushNamed('/home');
  user = request["user"];
}

void register(
  request, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!request["success"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "Erro ao registrar",
      backgroundColor: TW3Colors.red.shade500,
    );

    return;
  }

  var navigatorState = navigatorKey.currentState;

  if (navigatorState == null) {
    showSnackBarWithKey(
      scaffoldKey,
      "navigatorState é null",
      backgroundColor: TW3Colors.red.shade500,
    );
    return;
  }

  navigatorState.pushNamed('/');
  showSnackBarWithKey(
    scaffoldKey,
    "Registrado com sucesso",
    backgroundColor: TW3Colors.green.shade500,
  );
}

var handlers = {
  103: login,
  101: register,
};

class ClientService extends ChangeNotifier {
  Socket? socket;
  ConnectionStatus status = ConnectionStatus.disconnected;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final GlobalKey<NavigatorState> navigatorKey;

  ClientService({required this.scaffoldKey, required this.navigatorKey});

  void chooseHandle(Map request) {
    print("object $request");

    int? code = request["code"] as int?;

    if (code == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: no code was provided",
        backgroundColor: TW3Colors.red.shade500,
      );
      return;
    }

    var handler = handlers[code];

    if (handler == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: unknown code provided",
        backgroundColor: TW3Colors.red.shade500,
      );
      return;
    }

    handler(
      request,
      navigatorKey: navigatorKey,
      scaffoldKey: scaffoldKey,
    );
  }

  void connect({
    required String ip,
    required int port,
  }) async {
    try {
      socket = await Socket.connect(ip, port);
    } catch (error) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: $error",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    if (socket == null) {
      return;
    }

    showSnackBarWithKey(
      scaffoldKey,
      "Connected",
      backgroundColor: TW3Colors.green.shade500,
    );
    status = ConnectionStatus.connected;

    debugPrint("Client: Connected to ${socket!.remoteAddress.address}");

    socket!.listen(
      (event) {
        String strEvent = String.fromCharCodes(event);

        // showSnackBarWithKey(
        //   scaffoldKey,
        //   "RECIEVED: $strEvent",
        //   backgroundColor: TW3Colors.blue.shade500,
        // );

        var response = jsonDecode(strEvent);

        chooseHandle(response);
      },
      onError: (error) {
        debugPrint("Client: Socket error: $error");

        socket!.destroy();
      },
      onDone: () {
        debugPrint("Client: Socket done");

        socket!.destroy();
      },
    );

    notifyListeners();
    socket!.done.then((value) {
      showSnackBarWithKey(
        scaffoldKey,
        "Disconnect",
        backgroundColor: TW3Colors.red.shade500,
      );

      status = ConnectionStatus.disconnected;
      notifyListeners();
    });
  }

  void disconnect() async {
    if (socket == null) {
      return;
    }

    await socket!.close();
  }

  void login({required String cpf, required String password}) {
    if (socket == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: Socket is null",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    var request = {"code": 3, "cpf": cpf, "password": password};

    socket!.write(json.encode(request));
  }

  void register({
    required String name,
    required String cpf,
    required String password,
    required String birthday,
    required String sex,
    required bool stats,
  }) {
    if (socket == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: Socket is null",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    var request = {
      "code": 1,
      "name": name,
      "cpf": cpf,
      "password": password,
      "birthday": birthday,
      "sex": sex,
      "stats": stats
    };

    socket!.write(json.encode(request));
  }

  void logout({required String cpf}) {
    if (socket == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: Socket is null",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    var request = {
      "code": 14,
      "cpf": cpf,
      "status": false,
    };

    socket!.write(json.encode(request));
  }

  void sorting({
    required String description,
    required String priority,
  }) {
    if (socket == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: Socket is null",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    var request = {
      "code": 9,
      "cpf": user["cpf"],
      "description": description,
      "priority": priority,
    };

    socket!.write(json.encode(request));
  }
}
