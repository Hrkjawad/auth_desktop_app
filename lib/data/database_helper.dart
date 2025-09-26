import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  static Database? _dataBase;

  static Future<Database> init() async {
    if (_dataBase != null) return _dataBase!;
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "auth.db");

    _dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            email TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
    return _dataBase!;
  }
}
