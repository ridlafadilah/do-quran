import 'package:dio/dio.dart';
import 'package:do_core/api/bookmarks/bookmarks_api.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_core/models/quran/category_bookmarks.dart';
import 'package:do_core/models/quran/entity/category_bookmarks_entity.dart';
import 'package:do_core/models/quran/entity/verses_bookmarks_entity.dart';
import 'package:do_core/repository/verses_bookmarks_dao.dart';

class BookmarksService {
  final BookmarksAPI _bookmarksAPI = BookmarksAPI(Dio());
  final BookmarksDao _bookmarksDao = BookmarksDao();
  final VersesBookmarksDao _versesDao = VersesBookmarksDao();
  List<CategoryBookmarks> categoryBookmarks = [];

  Future<List<VersesBookmarks>> getBookmarks() async {
    Map<String, dynamic> version =
        await _bookmarksAPI.getVersion() as Map<String, dynamic>;
    String currentVersion = await _bookmarksDao.getByVersion();
    if (currentVersion != version['version']) {
      categoryBookmarks = await _bookmarksAPI.downloadBookmarks();
      await _bookmarksDao.deleteCategoryByVersion(currentVersion);
      for (CategoryBookmarks value in categoryBookmarks) {
        final List<VersesBookmarksEntity> verses = value.verses
            ?.map((e) =>
                e == null ? null : VersesBookmarksEntity.fromJson(e.toJson()))
            ?.toList();
        final CategoryBookmarksEntity categoryBookmarksEntity =
            CategoryBookmarksEntity.fromJson(value.toJson());
        categoryBookmarksEntity.version = version['version'];
        int idCategory = await _bookmarksDao.save(categoryBookmarksEntity);
        await _versesDao.saveVersesByCategory(verses, idCategory);
      }
    }
    List<VersesBookmarksEntity> versesBookmarksEntity =
        await _versesDao.getAll();
    List<VersesBookmarks> versesBookmarks = versesBookmarksEntity
        ?.map((e) => e == null ? null : VersesBookmarks.fromJson(e.toJson()))
        ?.toList();
    return versesBookmarks;
  }
}
