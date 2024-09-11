import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> copyDatabase() async {
  String dbPath = join(await getDatabasesPath(), 'Teacher.db');

  if (await File(dbPath).exists() == false) {
    ByteData data = await rootBundle.load('assets/Teacher.db');
    await writeToFile(data, dbPath);
  }

  Database db = await openDatabase(dbPath);
  return db;
}

Future<void> writeToFile(ByteData data, String path) async {
  final buffer = data.buffer;
  await File(path).writeAsBytes(
    buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    flush: true,
  );
}
