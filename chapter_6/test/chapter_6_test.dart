import 'dart:io';

import 'package:chapter_6/chapter_6.dart';
import 'package:chapter_6/src/lab_11/task_1.dart';
import 'package:test/test.dart';

void main() {
  test('Copy file by stream', () async {
    File copyOper = await copyFileByStream('bin\\lab_11.txt');

    var inputFile = File('bin\\lab_11.txt');
    var outputFile = File('bin\\lab_11_copy.txt');

    expect(copyOper.existsSync(), true);
    expect(inputFile.readAsStringSync(), outputFile.readAsStringSync());

    outputFile.deleteSync();
  });

  test('Copy file by future', () async {
    File copyOper = await copyFileByFuture('bin\\lab_11.txt');

    var inputFile = File('bin\\lab_11.txt');
    var outputFile = File('bin\\lab_11_copy.txt');

    expect(copyOper.existsSync(), true);
    expect(inputFile.readAsStringSync(), outputFile.readAsStringSync());

    outputFile.deleteSync();
  });

  test("exception on Input file not exists", () {
    expect(
      copyFileByFuture('bin\\unexisting_file.txt'),
      throwsA(isA<FileSystemException>()),
    );

    expect(
      copyFileByStream('bin\\unexisting_file.txt'),
      throwsA(isA<FileSystemException>()),
    );
  });
}
