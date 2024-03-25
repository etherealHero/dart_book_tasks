import 'dart:io';

void main(List<String> arguments) async {
  final server = await ServerSocket.bind('localhost', 2714);
  server.listen((client) async {
    var file = File('bin\\send.txt');

    if (!file.existsSync()) {
      file.createSync();
    }

    await file.openRead().pipe(client);
  });
}
