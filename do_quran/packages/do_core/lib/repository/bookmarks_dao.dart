import 'package:do_core/models/quran/entity/category_bookmarks_entity.dart';
import 'package:do_core/repository/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class BookmarksDao extends BaseDao<CategoryBookmarksEntity> {
  BookmarksDao() : super(tableName: 'category_bookmarks');

  Future<int> countByVersion(String version) async {
    final db = await dbProvider.database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM category_bookmarks '
            'WHERE version = "$version"'));
    return count;
  }

  Future<String> getByVersion() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT version FROM category_bookmarks LIMIT 1');
    String version = result.isEmpty ? '' : result[0]['version'];
    return version;
  }

  @override
  Future<int> save(CategoryBookmarksEntity baseEntity) async {
    final db = await dbProvider.database;
    return await db.insert(tableName, baseEntity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteCategoryByVersion(String version) async {
    final db = await dbProvider.database;
    return await db
        .delete(tableName, where: 'version = ?', whereArgs: [version]);
  }
}
