import 'dart:io';
import 'package:client/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:client/services/response_handlers/response_handlers.dart';
import 'dart:convert';

enum ConnectionStatus { connected, loading, disconnected }

class ClientService extends ChangeNotifier {
  Socket? socket;
  ConnectionStatus status = ConnectionStatus.disconnected;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final GlobalKey<NavigatorState> navigatorKey;
  dynamic user;
  Map<int, Function> responseCallbacks = {};

  ClientService({required this.scaffoldKey, required this.navigatorKey});

  Socket? getSocket() {
    if (socket == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: Socket is null",
        backgroundColor: TW3Colors.red.shade500,
      );

      return null;
    }

    return socket;
  }

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

    var responseCallback = responseCallbacks[code];

    if (responseCallback != null) {
      responseCallback(response);
    }

    if (code == 103) {
      user = response["user"];
    }
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
    print("sendRequest $request");
    String strRequest = json.encode(request);

    print("sent - $strRequest");

    socket!.writeln(strRequest);
  }

  void login({required String cpf, required String password}) {
    var socket = getSocket();

    if (socket == null) {
      return;
    }

    var request = {"code": 3, "cpf": cpf, "password": password};

    sendRequest(request);
  }

  void register({
    required String name,
    required String cpf,
    required String password,
    required String birthday,
    required String sex,
    required bool stats,
  }) {
    var socket = getSocket();

    if (socket == null) {
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

    sendRequest(request);
  }

  void logout() {
    var socket = getSocket();

    if (socket == null) {
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

    sendRequest(request);
  }

  void sorting({
    required String description,
    required String priority,
  }) {
    var socket = getSocket();

    if (socket == null) {
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

    sendRequest(request);
  }

  void nextPatient(Function responseCallback) {
    var socket = getSocket();

    if (socket == null) {
      return;
    }

    var request = {
      "code": 18,
    };

    responseCallbacks[118] = responseCallback;

    sendRequest(request);
  }

  void patientQueue(Function responseCallback) {
    var socket = getSocket();

    if (socket == null) {
      return;
    }

    if (user['cpf'] == null) {
      showSnackBarWithKey(
        scaffoldKey,
        "Error: CPF not found",
        backgroundColor: TW3Colors.red.shade500,
      );
    }

    var request = {
      "code": 10,
      "cpf": user["cpf"],
    };

    responseCallbacks[110] = responseCallback;

    // print("send request", request);
    sendRequest(request);
  }
}
