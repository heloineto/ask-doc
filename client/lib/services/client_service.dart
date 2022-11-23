import 'dart:io';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'dart:convert';

enum ConnectionStatus { connected, loading, disconnected }

var user;

void login(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!response["status"]) {
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
  user = response["user"];
}

void register(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!response["success"]) {
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

void logout(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {}

void sorting(
  response, {
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  if (!response["success"]) {
    showSnackBarWithKey(
      scaffoldKey,
      "O servidor não permitiu a operação de triagem",
      backgroundColor: TW3Colors.red.shade500,
    );

    return;
  }
}

var responseHandlers = {103: login, 101: register, 114: logout, 109: sorting};

class ClientService extends ChangeNotifier {
  Socket? socket;
  ConnectionStatus status = ConnectionStatus.disconnected;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final GlobalKey<NavigatorState> navigatorKey;

  ClientService({required this.scaffoldKey, required this.navigatorKey});

  void handleResponse(Map response) {
    print("recieved - $response");

    int? code = response["code"] as int?;

    if (code == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: no code was provided",
        backgroundColor: TW3Colors.red.shade500,
      );
      return;
    }

    var handler = responseHandlers[code];

    if (handler == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: unknown code provided",
        backgroundColor: TW3Colors.red.shade500,
      );
      return;
    }

    handler(
      response,
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
        var response = jsonDecode(strEvent);

        handleResponse(response);
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

  void sendRequest(Map request) {
    String strRequest = json.encode(request);

    print("sent - $strRequest");

    socket!.write(strRequest);
    socket!.flush();
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
    socket!.flush();
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
    socket!.flush();
  }

  void logout() {
    if (socket == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: Socket is null",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    if (user['cpf'] == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: CPF not found",
        backgroundColor: TW3Colors.red.shade500,
      );

      return;
    }

    var request = {
      "code": 14,
      "cpf": user['cpf'],
      "status": false,
    };

    socket!.write(json.encode(request));
    socket!.flush();
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

    if (user['cpf'] == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: CPF not found",
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
    socket!.flush();
  }
}
