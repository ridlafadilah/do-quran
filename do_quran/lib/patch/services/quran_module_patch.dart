import 'package:do_core/core.dart';
import 'package:do_core/models.dart';

class QuranModulePatch extends CommonModulePatch {
  QuranModulePatch() : super(description: 'Qur\'an Info');

  final QuranInfoDao quranInfoDao = QuranInfoDao();

  @override
  Future<bool> doCheck() async {
    int count = await quranInfoDao.count;
    return count == 114 ?? false;
  }

  @override
  Future doProcess() async {
    List<QuranInfo> _quranInfoList = await getQuranInfo();
    await quranInfoDao.deleteAll();
    _quranInfoList.forEach((quran) async {
      QuranInfoEntity quranInfoEntity =
          QuranInfoEntity.fromJson(quran.toJson());
      await quranInfoDao.save(quranInfoEntity);
    });
  }

  Future<List<QuranInfo>> getQuranInfo() {
    final QuranService quranService = QuranService();
    return quranService.downloadQuran();
  }
}
