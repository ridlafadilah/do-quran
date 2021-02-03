import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(InitialState());

  @override
  Stream<SurahState> mapEventToState(SurahEvent event) async* {
    if (event is RequestedEvent) {
      yield RequestInProgressState();
      try {
        Surah data = await getSurah(event.numberOfSurah);
        yield RequestSuccessState(surah: data);
      } on ServerError catch (e) {
        yield RequestFailureState(error: e.getErrorMessage());
      }
    }
  }

  Future<Surah> getSurah(int numberOfSurah) async {
    final SurahDao surahDao = SurahDao();
    final SurahEntity surahEntity = await surahDao.getSurah(numberOfSurah);
    final Surah surah = Surah(
        name: surahEntity.name,
        nameLatin: surahEntity.nameLatin,
        number: surahEntity.number,
        numberOfAyah: surahEntity.totalAyah);
    final Map<String, String> text = {};
    surahEntity.ayah.forEach((value) {
      text[value.numberOfAyah] = value.text;
    });
    surah.text = text;
    final Map<String, String> textTranslation = {};
    String nameTranslation;
    surahEntity.translations.forEach((value) {
      textTranslation[value.numberOfAyah] = value.text;
      nameTranslation = value.nameLatinSurah;
    });
    final TranslationsId id =
        TranslationsId(name: nameTranslation, text: textTranslation);
    final Translations translations = Translations(id: id);
    surah.translations = translations;
    return surah;
  }

  Future<Surah> getData(int numberOfSurah) {
    final QuranService quranService = QuranService();
    return quranService.loadSurah(numberOfSurah);
  }
}
