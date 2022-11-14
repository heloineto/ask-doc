import 'dart:io';

Future<void> runPocketbase() async {
  var result = await Process.run('./pocketbase.exe', ['serve']);

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  print('\n');
}
