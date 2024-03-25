import 'dart:io';
import 'dart:typed_data';

void main(List<String> arguments) async {
  var socket = await Socket.connect('localhost', 2714);
  try {
    print(
        "Connected to:" '${socket.remoteAddress.address}:${socket.remotePort}');
    socket.write('Send Data');

    var file = File('bin\\received.txt').openWrite();
    try {
      await socket.map(toIntList).pipe(file);
    } finally {
      file.close();
    }
  } finally {
    socket.destroy();
  }
}

List<int> toIntList(Uint8List source) {
  return List.from(source);
}
