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
      'description TEXT, '
      'type TEXT DEFAULT "PINNED_AYAH", '
      'version TEXT DEFAULT "0" '
      ')';
  static final String versesBookmarksTable = 'CREATE TABLE verses_bookmarks ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'surah INTEGER, '
      'surah_name TEXT, '
      'ayah INTEGER, '
      'ayah_text TEXT, '
      'ayah_translation TEXT, '
      'notes TEXT, '
      'id_category INTEGER, '
      'FOREIGN KEY (id_category) REFERENCES category_bookmarks (id) '
      'ON DELETE CASCADE ON UPDATE NO ACTION '
      ')';
}
