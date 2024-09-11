import 'package:cht_flutter/database/teacher_service.dart';
import 'package:cht_flutter/model/teacher.dart';
import 'package:sqflite/sqflite.dart';

class Teacherdb {
  final tableName = 'teacher';

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        birth TEXT,
        email TEXT,
        image TEXT,
        name TEXT,
        phonenumber TEXT,
        subject TEXT
      );
    ''');
  }

  Future<int> create({required int id,
                      required String birth,
                      required String email,
                      required String image,
                      required String name,
                      required String phonenumber,
                      required String subject}) async {
    final database = await TeacherService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (id, birth, email, image, name, phonenumber, subject) VALUES (?, ?, ?, ?, ?, ?, ?)''',
      [id, birth, email, image, name, phonenumber, subject]
    );
  }

  Future<List<Teacher>> fetchAll() async {
    final database = await TeacherService().database;

    final teacher = await database.rawQuery(
      '''SELECT * from $tableName'''
    );

    return teacher.map((teacherList) => Teacher.fromSqfliteDatabase(teacherList)).toList();
  }

  Future<List<Teacher>> searchByName(String name) async {
    final database = await TeacherService().database;
    final teacher = await database.rawQuery(
      '''SELECT * from $tableName WHERE name LIKE ?''',
      ['%$name%']
    );

    return teacher.map((teacherList) => Teacher.fromSqfliteDatabase(teacherList)).toList();
  }
}