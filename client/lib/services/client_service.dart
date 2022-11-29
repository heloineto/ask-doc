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

  void showError(String message) {
    showSnackBarWithKey(
      scaffoldKey,
      message,
      backgroundColor: TW3Colors.red.shade500,
    );
  }

  void handleResponse(Map response) {
    print("received - $response");

    int? code = response["code"] as int?;

    if (code == null) {
      showError("Error: no code was provided");
      return;
    }

    var handler = responseHandlers[code];

    if (handler == null) {
      showError("Error: unknown code provided");
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
      showError("Error: $error");
      return;
    }

    if (socket == null) {
      showError("Error: Socket is null");
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
      showError("Disconnect");

      status = ConnectionStatus.disconnected;
      notifyListeners();
    });
  }

  void disconnect() async {
    if (socket == null) {
      showError("Can't disconnect: socket is null");
      return;
    }

    await socket!.close();
  }

  void sendRequest(Map request) {
    if (socket == null) {
      showError("Error: Socket is null");
      return;
    }

    String strRequest = json.encode(request);

    print("sent - $strRequest");

    socket!.writeln(strRequest);
  }

  void login({required String cpf, required String password}) {
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
    if (user?['cpf'] == null) {
      showError("Error: CPF not found");
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
    if (user?['cpf'] == null) {
      showError("Error: CPF not found");
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
    var request = {
      "code": 18,
    };

    responseCallbacks[118] = responseCallback;

    sendRequest(request);
  }

  void patientQueue(Function responseCallback) {
    if (user?['cpf'] == null) {
      showError("Error: CPF not found");
      return;
    }

    var request = {
      "code": 10,
      "cpf": user["cpf"],
    };

    responseCallbacks[110] = responseCallback;

    sendRequest(request);
  }
}
