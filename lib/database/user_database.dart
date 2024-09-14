import 'package:cht_flutter/database/user_service.dart';
import 'package:cht_flutter/model/user.dart';
import 'package:sqflite/sqflite.dart';

class Userdb {
  final tableName = 'user';

  Future<void> createTable(Database database) async {
    await database.execute(
      '''CREATE TABLE IF NOT EXISTS $tableName (
        name TEXT PRIMARY KEY,
        class TEXT NOT NULL,
        image TEXT
      );'''
    );
  }

  Future<int> create({required String name, required String className}) async {
    final database = await UserService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (name, class, image) VALUES (?, ?, ?)''',
      [name, className]
    );
  }

  Future<int> updateClass(String className) async {
    final database = await UserService().database;
    return await database.rawUpdate(
        '''UPDATE $tableName SET class = ?''',
        [className]
    );
  }

  Future<int> updateUser(String name, String className, String? imagePath) async {
    final database = await UserService().database;
    return await database.rawUpdate(
        '''
    UPDATE $tableName 
    SET class = ?, image = ?
    WHERE name = ?
    ''',
        [className, imagePath, name]
    );
  }

  Future<List<User>> fetchAll() async {
    final database = await UserService().database;
    final user = await database.rawQuery(
        '''SELECT * from $tableName'''
    );
    return user.map((userChoose) => User.fromSqfliteDatabase(userChoose)).toList();
  }
}