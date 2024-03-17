import 'package:database_5_5/database_5_5.dart';

import 'menu.dart';

void main(List<String> arguments) {
  var db = Database(
    pathToSuaiDB: 'bin\\suai.txt',
    pathToUneconDB: 'bin\\unecon.txt',
  );
  var menu = Menu(db);
  menu.loop();
}
