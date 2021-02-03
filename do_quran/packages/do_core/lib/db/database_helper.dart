class DBHelper {
  static final int databaseVersion = 1;
  static final String databaseName = 'quran.db';
  static final String quranInfoTable = 'CREATE TABLE quran_info ('
      'idx INTEGER PRIMARY KEY, '
      'translation_id TEXT, '
      'translation_en TEXT, '
      'arabic TEXT, '
      'latin TEXT, '
      'ayah_count INTEGER, '
      'opening TEXT, '
      'closing TEXT '
      ')';
  static final String surahTable = 'CREATE TABLE surah ('
      'number TEXT PRIMARY KEY, '
      'name TEXT, '
      'name_latin TEXT, '
      'total_ayah TEXT'
      ')';
  static final String ayahTable = 'CREATE TABLE ayah ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'number_of_ayah TEXT, '
      'text TEXT, '
      'id_surah TEXT, '
      'FOREIGN KEY (id_surah) REFERENCES surah (number) '
      'ON DELETE CASCADE ON UPDATE NO ACTION '
      ')';
  static final String ayahTranslationTable = 'CREATE TABLE ayah_translation ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'name_latin_surah TEXT, '
      'number_of_ayah TEXT, '
      'text TEXT, '
      'l10n TEXT, '
      'id_surah TEXT, '
      'FOREIGN KEY (id_surah) REFERENCES surah (number) '
      'ON DELETE CASCADE ON UPDATE NO ACTION '
      ')';
  static final String categoryBookmarksTable =
      'CREATE TABLE category_bookmarks ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title TEXT, '
      'type TEXT DEFAULT "PINNED" '
      ')';
  static final String ayahBookmarksTable = 'CREATE TABLE ayah_bookmarks ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'number_of_surah INTEGER, '
      'number_of_ayah INTEGER, '
      'description TEXT, '
      'id_category INTEGER, '
      'FOREIGN KEY (id_category) REFERENCES ayah_bookmarks (id) '
      'ON DELETE CASCADE ON UPDATE NO ACTION '
      ')';
}
