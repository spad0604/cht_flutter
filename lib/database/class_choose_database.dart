import 'package:cht_flutter/database/class_choose_service.dart';
import 'package:cht_flutter/model/class_choose.dart';
import 'package:sqflite/sqflite.dart';

class Classdb {
  final tableName = 'class';

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        class TEXT NOT NULL
      );
    ''');
  }

  Future<int> create({required String classChoose}) async {
    final database = await ClassService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (class) VALUES (?)''',
      [classChoose],
    );
  }

  Future<int> update({required String newClass}) async {
    final database = await ClassService().database;
    return await database.rawUpdate(
      '''
      UPDATE $tableName 
      SET class = ? 
      WHERE id = 1
      ''',
      [newClass],
    );
  }

  Future<List<ClassChoose>> fetchAll() async {
    final database = await ClassService().database;
    final classChoose = await database.rawQuery(
      '''SELECT * from $tableName'''
    );
    return classChoose.map((classList) => ClassChoose.fromSqfliteDatabase(classList)).toList();
  }
}
