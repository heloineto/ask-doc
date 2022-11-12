import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ask Doc',
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: ThemeData.dark().copyWith(
        primaryColor: TW3Colors.green,
        textTheme: GoogleFonts.interTextTheme(),
      ),
    );
  }
}
