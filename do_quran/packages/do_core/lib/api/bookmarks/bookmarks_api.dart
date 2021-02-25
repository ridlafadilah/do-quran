import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/models/quran/category_bookmarks.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:retrofit/http.dart';

part 'bookmarks_api.g.dart';

@RestApi()
abstract class BookmarksAPI {
  factory BookmarksAPI(Dio dio) {
    final String baseUrl =
        GlobalConfiguration().getValue('hosts')['bookmarks']['host'];
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    return _BookmarksAPI(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/json'})
  @GET('/do-quran/bookmarks/version.json')
  Future<dynamic> getVersion();

  @Headers({'content-type': 'application/json'})
  @GET('/do-quran/bookmarks/bookmarks.json')
  Future<List<CategoryBookmarks>> downloadBookmarks();
}
