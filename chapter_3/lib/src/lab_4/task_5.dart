import 'dart:io';
import '/src/shared.dart';

var task = Task("""
22. Пользователь вводит с клавиатуры две Map<String, int> (point1 и
point2) вида: {'х' : 10, 'у' : 13}. Напишите функцию, которая возвращает
значение расстояния между заданными точками. Аргумент функции point2
должен иметь следующее значение по умолчанию {'х' : -7, 'у' : 3}, на случай
если пользователь введет не две Map. Полученный результат выведите в
терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите название осей точки 1: ");

  stdout.write("Введите значение осей точки 1: ");

  stdout.write("Введите название осей точки 2: ");

  stdout.write("Введите значение осей точки 2: ");

  stdout.write("Расстояние между точками: ");
}

double getDistance(Map<String, int> pointOne, Map<String, int> pointTwo) {
  return 1.0;
}
