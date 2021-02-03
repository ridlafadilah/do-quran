import 'package:do_core/models/quran/entity/quran_info_entity.dart';
import 'package:do_core/repository/base_dao.dart';

class QuranInfoDao extends BaseDao<QuranInfoEntity> {
  QuranInfoDao() : super(tableName: 'quran_info');

  Future<List<QuranInfoEntity>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<QuranInfoEntity> quran = result.isNotEmpty
        ? result.map((item) => QuranInfoEntity.fromJson(item)).toList()
        : [];
    return quran;
  }

  Future<List<QuranInfoEntity>> getQuranInfoQuery(
      {List<String> columns, String query}) async {
    List<Map<String, dynamic>> result =
        await getQuery(columns: columns, query: query);
    List<QuranInfoEntity> quranInfo = result.isNotEmpty
        ? result.map((item) => QuranInfoEntity.fromJson(item)).toList()
        : [];
    return quranInfo;
  }

  Future<int> update(QuranInfoEntity quranInfo) async {
    final db = await dbProvider.database;
    var result = await db.update(tableName, quranInfo.toJson(),
        where: 'index = ?', whereArgs: [quranInfo.index]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(tableName, where: 'index = ?', whereArgs: [id]);
    return result;
  }
}
