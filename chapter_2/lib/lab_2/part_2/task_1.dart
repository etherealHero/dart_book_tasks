import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
1. Пользователь вводит строку. Используя шаблон выведите ее в
терминал, если строка удовлетворяет следующим условиям: 0 < длина < 15
и начинается на букву «W». Иначе выведите текст «Pattern no matched».
""", execute);

void execute(List<String> arguments) {
  stdout.write("");
}
