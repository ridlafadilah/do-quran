import 'dart:ui';

import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'translation_event.dart';
part 'translation_state.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  TranslationBloc()
      : super(const TranslationState(
            locale: Locale.fromSubtags(languageCode: 'en', countryCode: 'US')));
  final LanguageService languageService = LanguageService();

  @override
  Stream<TranslationState> mapEventToState(TranslationEvent event) async* {
    final LocaleDto locale = languageService.getCurrentLocale();
    yield TranslationState(locale: getLanguageCode(locale));
  }

  Locale getLanguageCode(LocaleDto locale) {
    return Locale.fromSubtags(
        languageCode: locale.localeCode.split('-')[0],
        countryCode: locale.localeCode.split('-')[1]);
  }
}
