final ipRegex = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$');

bool validateIp(String ip) {
  return ipRegex.hasMatch(ip);
}

bool validatePort(String portStr) {
  int? port;

  port = int.tryParse(portStr);

  if (port == null) return false;
  if (port < 1 || port > 65535) return false;

  return true;
}
