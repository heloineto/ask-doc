import 'package:client/home/home.dart';
import 'package:client/login/login.dart';
import 'package:client/registration/registration.dart';
import 'package:client/sorting/sorting.dart';
import 'package:client/sorting/sorting_form.dart';
import 'package:flutter/cupertino.dart';

Map<String, StatelessWidget Function(dynamic)> routes = {
  '/': (context) => const SortingScreen(),
  '/home': (context) => const HomeScreen(),
  '/registration': (context) => const RegistrationScreen(),
  '/sorting': (context) => const SortingScreen(),
};
