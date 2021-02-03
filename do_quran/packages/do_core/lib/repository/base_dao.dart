import 'package:do_core/db/database_provider.dart';
import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:sqflite/sqflite.dart';

class BaseDao<T extends BaseEntity> {
  BaseDao({this.tableName});

  final String tableName;
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> get count async {
    final db = await dbProvider.database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
    return count;
  }

  Future<List<Map<String, dynamic>>> getQuery(
      {List<String> columns, String query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(tableName,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ['%$query%']);
    } else {
      result = await db.query(tableName, columns: columns);
    }
    return result;
  }

  Future<dynamic> save(T baseEntity) async {
    final db = await dbProvider.database;
    var result = db.insert(tableName, baseEntity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future deleteAll() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      tableName,
    );
    return result;
  }
}
