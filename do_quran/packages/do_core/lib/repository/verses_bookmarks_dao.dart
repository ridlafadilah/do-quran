import 'package:do_core/core.dart';
import 'package:do_core/models/quran/entity/surah_entity.dart';
import 'package:do_core/models/quran/entity/verses_bookmarks_entity.dart';
import 'package:do_core/repository/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class VersesBookmarksDao extends BaseDao<VersesBookmarksEntity> {
  VersesBookmarksDao() : super(tableName: 'verses_bookmarks');

  Future<List<VersesBookmarksEntity>> getAll() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = [];
    result = await db.query(tableName);
    List<VersesBookmarksEntity> verses = result.isNotEmpty
        ? result
            .map((item) =>
                item == null ? null : VersesBookmarksEntity.fromJson(item))
            ?.toList()
        : [];
    return verses;
  }

  Future<List<VersesBookmarksEntity>> getByCategory(int id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = [];
    result = await db.query(
      tableName,
      where: 'id_category = ?',
      whereArgs: [id],
    );
    List<VersesBookmarksEntity> verses = result.isNotEmpty
        ? result
            .map((item) =>
                item == null ? null : VersesBookmarksEntity.fromJson(item))
            ?.toList()
        : [];
    return verses;
  }

  Future<void> saveVersesByCategory(
      List<VersesBookmarksEntity> verses, int idCategory) async {
    final db = await dbProvider.database;
    final SurahDao surahDao = SurahDao();
    Batch batch = db.batch();
    for (VersesBookmarksEntity value in verses) {
      SurahEntity surah =
          await surahDao.getSurahByAyah(value.surah, value.ayah);
      value.surahName = surah.nameLatin;
      value.ayahText = surah.ayah[0].text;
      value.ayahTranslation = surah.translations[0].text;
      value.idCategory = idCategory;
      batch.insert(tableName, value.toJson());
    }
    await batch.commit(noResult: true, continueOnError: false);
  }
}
