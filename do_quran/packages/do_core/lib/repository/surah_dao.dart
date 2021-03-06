import 'package:do_core/models/quran/entity/ayah_entity.dart';
import 'package:do_core/models/quran/entity/ayah_translation_entity.dart';
import 'package:do_core/models/quran/entity/surah_entity.dart';
import 'package:do_core/repository/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class SurahDao extends BaseDao<SurahEntity> {
  SurahDao() : super(tableName: 'surah');

  Future<int> countSurah(int numberOfSurah) async {
    final db = await dbProvider.database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(surah.number) FROM surah '
            'LEFT JOIN ayah ON ayah.id_surah = surah.number '
            'WHERE surah.number = $numberOfSurah'));
    return count;
  }

  Future<SurahEntity> getSurah(int numberOfSurah) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = [];
    result = await db.query(
      tableName,
      where: 'number = ?',
      whereArgs: [numberOfSurah],
    );
    List<SurahEntity> surahList = result.isNotEmpty
        ? result.map((item) => SurahEntity.fromJson(item)).toList()
        : [];
    result = await db.query(
      'ayah',
      where: 'id_surah = ?',
      whereArgs: [numberOfSurah],
    );
    List<AyahEntity> ayahList = result.isNotEmpty
        ? result.map((item) => AyahEntity.fromJson(item)).toList()
        : [];
    result = await db.query(
      'ayah_translation',
      where: 'id_surah = ?',
      whereArgs: [numberOfSurah],
    );
    List<AyahTranslationEntity> translations = result.isNotEmpty
        ? result.map((item) => AyahTranslationEntity.fromJson(item)).toList()
        : [];
    SurahEntity surah = surahList.first;
    surah.ayah = ayahList;
    surah.translations = translations;
    return surah;
  }

  Future<SurahEntity> getSurahByAyah(
      int numberOfSurah, int numberOfAyah) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = [];
    result = await db.query(
      tableName,
      where: 'number = ?',
      whereArgs: [numberOfSurah],
    );
    List<SurahEntity> surahList = result.isNotEmpty
        ? result.map((item) => SurahEntity.fromJson(item)).toList()
        : [];
    result = await db.query(
      'ayah',
      where: 'id_surah = ? AND number_of_ayah = ?',
      whereArgs: [numberOfSurah, numberOfAyah],
    );
    List<AyahEntity> ayahList = result.isNotEmpty
        ? result.map((item) => AyahEntity.fromJson(item)).toList()
        : [];
    result = await db.query(
      'ayah_translation',
      where: 'id_surah = ? AND number_of_ayah = ?',
      whereArgs: [numberOfSurah, numberOfAyah],
    );
    List<AyahTranslationEntity> translations = result.isNotEmpty
        ? result.map((item) => AyahTranslationEntity.fromJson(item)).toList()
        : [];
    SurahEntity surah = surahList.first;
    surah.ayah = ayahList;
    surah.translations = translations;
    return surah;
  }

  Future<List<SurahEntity>> getSurahQuery(
      {List<String> columns, String query}) async {
    List<Map<String, dynamic>> result =
        await getQuery(columns: columns, query: query);
    List<SurahEntity> surah = result.isNotEmpty
        ? result.map((item) => SurahEntity.fromJson(item)).toList()
        : [];
    return surah;
  }

  @override
  Future save(SurahEntity baseEntity) async {
    final db = await dbProvider.database;
    await db.insert(tableName, baseEntity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    Batch batch = db.batch();
    for (AyahEntity value in baseEntity.ayah) {
      // await db.insert('ayah', value.toJson());
      batch.insert('ayah', value.toJson());
    }
    for (AyahTranslationEntity value in baseEntity.translations) {
      // await db.insert('ayah_translation', value.toJson());
      batch.insert('ayah_translation', value.toJson());
    }
    await batch.commit(noResult: true);
  }

  Future<int> update(SurahEntity surah) async {
    final db = await dbProvider.database;
    var result = await db.update(tableName, surah.toJson(),
        where: 'number = ?', whereArgs: [surah.number]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(tableName, where: 'number = ?', whereArgs: [id]);
    return result;
  }

  Future deleteSurah(int numberOfSurah) async {
    final db = await dbProvider.database;
    /*
    await db.delete('ayah', where: 'id_surah = ?', whereArgs: [numberOfSurah]);
    await db.delete('ayah_translation',
        where: 'id_surah = ?', whereArgs: [numberOfSurah]);
    */
    await db.delete(tableName, where: 'number = ?', whereArgs: [numberOfSurah]);
  }
}
