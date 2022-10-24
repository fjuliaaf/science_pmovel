import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class messageHelper {
  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "julia1.db");
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );

    return database;
  }

  Future<FutureOr<void>> onCreate(Database db, int version) async {
    String sql = 'create table MESSAGES (message VARCHAR(150));';
    await db.execute(sql);

    sql = "INSERT INTO MESSAGES (message) "
        "VALUES ('Primeira mensagem do forum.');";
    await db.execute(sql);
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {}
}
