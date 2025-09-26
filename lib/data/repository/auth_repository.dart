import 'package:auth_desktop_app/data/database_helper.dart';
import 'package:auth_desktop_app/data/model/user_info.dart';
import 'package:sqflite/sqflite.dart';

class AuthRepository {
  Future<int> register(UserInfo user) async {
    final database = await MyDatabase.init();
    return await database.insert(
      "users",
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserInfo?> login(String email, String password) async {
    final database = await MyDatabase.init();
    final result = await database.query(
      "users",
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return UserInfo.fromJson(result.first);
    }
    return null;
  }
}
