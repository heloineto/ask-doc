import 'package:ansicolor/ansicolor.dart';

void printThing(
  String message, {
  String? id,
  required AnsiPen pen,
  required String verb,
}) {
  AnsiPen blackPen = AnsiPen()..black();

  if (id == null) {
    print('${pen(verb)} - $message');
    return;
  }

  print('${pen(verb)} - $message ${blackPen('($id)')}');
}

void printError(String message, {String? id}) {
  printThing(message, pen: AnsiPen()..red(), verb: "error", id: id);
}

void printReady(String message, {String? id}) {
  printThing(message, pen: AnsiPen()..green(), verb: "ready", id: id);
}

void printInfo(String message, {String? id}) {
  printThing(message, pen: AnsiPen()..blue(), verb: "info", id: id);
}

void printEvent(String message, {String? id}) {
  printThing(message, pen: AnsiPen()..magenta(), verb: "event", id: id);
}

void printLogo() {
  var pen = AnsiPen()..white(bold: true);

  print(pen("""\n
     _        _      ____             
    / \\   ___| | __ |  _ \\  ___   ___ 
   / _ \\ / __| |/ / | | | |/ _ \\ / __|
  / ___ \\\\__ \\   <  | |_| | (_) | (__ 
 /_/   \\_\\___/_|\\_\\ |____/ \\___/ \\___|
\n"""));
}
