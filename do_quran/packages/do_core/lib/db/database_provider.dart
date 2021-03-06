import 'dart:async';
import 'dart:io';
import 'package:do_core/db/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBHelper.databaseName);
    var database = await openDatabase(path,
        version: DBHelper.databaseVersion,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onConfigure: onConfigure);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void onCreate(Database database, int version) async {
    Batch batch = database.batch();
    batch.execute(DBHelper.quranInfoTable);
    batch.execute(DBHelper.surahTable);
    batch.execute(DBHelper.ayahTable);
    batch.execute(DBHelper.ayahTranslationTable);
    batch.execute(DBHelper.categoryBookmarksTable);
    batch.execute(DBHelper.versesBookmarksTable);
    await batch.commit();
  }

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
