import 'dart:io';
import 'package:pocketbase/pocketbase.dart';

Future<void> runPocketbase() async {
  var result = await Process.run('./pocketbase.exe', ['serve']);

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  print('\n');
}

final client = PocketBase('http://127.0.0.1:8090');
