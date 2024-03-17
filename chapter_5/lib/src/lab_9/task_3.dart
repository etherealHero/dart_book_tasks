import 'dart:io';

import '/src/shared.dart';

var task = Task("""
12. Напишите приложение, которое считывает содержимое текстового
файла, записывает в новый файл и выводит в терминал самую часто
встречающуюся гласную и согласную букву.
""", execute);

void execute(List<String> arguments) {
  File file = File('bin\\task_3\\file.txt');

  List<String> vowels = "ауоиэыяюеё".split("");
  List<String> consonant = "бвгджзйклмнпрстфхцчшщ".split("");

  String fileData = file.readAsStringSync();

  var letterCountMap = <String, int>{};

  for (var symbol in fileData.split("")) {
    String? letter = RegExp(r'[а-я]').stringMatch(symbol.toLowerCase());

    if (letter != null) {
      if (letterCountMap.containsKey(letter)) {
        letterCountMap[letter] = letterCountMap[letter]! + 1;
      } else {
        letterCountMap[letter] = 1;
      }
    }
  }

  String? mostVowel;
  int maxVowelCount = 0;

  String? mostConsonant;
  int maxConsonantCount = 0;

  letterCountMap.forEach((key, value) {
    if (vowels.contains(key) && maxVowelCount < value) {
      maxVowelCount = value;
      mostVowel = key;
    }

    if (consonant.contains(key) && maxConsonantCount < value) {
      maxConsonantCount = value;
      mostConsonant = key;
    }
  });

  stdout.writeln("Гласная: $mostVowel");
  stdout.writeln("Согласная: $mostConsonant");

  var fileOutput = File("bin\\task_3\\file_output.txt");
  fileOutput.writeAsString("Гласная: $mostVowel\nСогласная: $mostConsonant");
}
