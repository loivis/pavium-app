import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Store {
  static Database db;

  static init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pavium.db');
    print("database path: $path");

    try {
      db = await openDatabase(path);
    } catch (e) {
      print("error opening database: $e");
    }

    bool intact = await checkDatabase();
    if (!intact) {
      db.close();
      await deleteDatabase(path);

      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          print('database created: version $version');
        },
        onOpen: (Database db) async {
          print('new database opened');
        },
      );
    } else {
      print("Opening existing database");
    }
  }

  // check database integrity. tables might be lost in certain android models.
  static Future<bool> checkDatabase() async {
    List<String> expectTables = ['cat', 'widget', 'collection'];

    List<String> tables = await getTables();

    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }

    return true;
  }

  static Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }

    List<String> tableList = [];

    var sql = 'SELECT name FROM sqlite_master WHERE type = "table"';
    db.rawQuery(sql).then((tables) {
      tables.forEach((item) => tableList.add(item['name']));
    });

    return tableList;
  }
}
