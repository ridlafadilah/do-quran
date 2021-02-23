import 'dart:convert';

import 'package:do_core/models/quran/category_bookmarks.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class BookmarksService {
  BookmarksService() {
    baseUrl = GlobalConfiguration().getValue('hosts')['bookmarks']['host'];
  }
  String baseUrl;

  Future<Map<String, String>> getVersion() async {
    var response = await http.get('$baseUrl/bookmarks/version.json');
    Map<String, String> data = json.decode(response.body);
    return data;
  }

  Future<List<CategoryBookmarks>> downloadBookmarks() async {
    var response = await http.get('$baseUrl/bookmarks/bookmarks.json');
    Iterable data = json.decode(response.body);
    return data.map((model) => CategoryBookmarks.fromJson(model)).toList();
  }
}
