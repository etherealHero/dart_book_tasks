import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
3. Пользователь вводит Map<int, String>. Используя шаблон выведите
его в терминал, если удовлетворяет следующим условиям: длина < 5,
имеется ключ со значением 999 или 666. Иначе выведите текст «Pattern no
matched».
""", execute);

void execute(List<String> arguments) {
  stdout.write("");
}
