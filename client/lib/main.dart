import 'package:client/routes.dart';
import 'package:client/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClientService(scaffoldKey: _scaffoldKey),
      child: MaterialApp(
        title: 'Ask Doc',
        scaffoldMessengerKey: _scaffoldKey,
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: ThemeData.dark().copyWith(
          primaryColor: TW3Colors.green,
          textTheme: GoogleFonts.interTextTheme(),
        ),
      ),
    );
  }
}
