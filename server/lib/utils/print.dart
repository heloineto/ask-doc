import 'package:ansicolor/ansicolor.dart';

void printError(String message) {
  AnsiPen pen = AnsiPen()..red();
  print(pen(message));
}

void printSuccess(String message) {
  AnsiPen pen = AnsiPen()..green();
  print(pen(message));
}

void printInfo(String message) {
  AnsiPen pen = AnsiPen()..gray();
  print(pen(message));
}
