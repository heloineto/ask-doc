import 'package:ansicolor/ansicolor.dart';

void printError(String message) {
  AnsiPen pen = AnsiPen()..red();
  print('${pen("error")} - $message');
}

void printReady(String message) {
  AnsiPen pen = AnsiPen()..green();
  print('${pen("ready")} - $message');
}

void printInfo(String message) {
  AnsiPen pen = AnsiPen()..blue();
  print('${pen("info")} - $message');
}

void printEvent(String message) {
  AnsiPen pen = AnsiPen()..magenta();
  print('${pen("event")} - $message');
}
