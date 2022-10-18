import 'package:client/login/login.dart';
import 'package:client/registration/registration.dart';
import 'package:flutter/cupertino.dart';

Map<String, StatelessWidget Function(dynamic)> routes = {
  '/': (context) => const LoginScreen(),
  '/registration': (context) => const RegistrationScreen(),
};
