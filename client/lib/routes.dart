import 'package:client/home/home.dart';
import 'package:client/login/login.dart';
import 'package:client/registration/registration.dart';
import 'package:flutter/cupertino.dart';

Map<String, StatelessWidget Function(dynamic)> routes = {
  '/': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),
  '/registration': (context) => const RegistrationScreen(),
};
