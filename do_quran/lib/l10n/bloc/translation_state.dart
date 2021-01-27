part of 'translation_bloc.dart';

class TranslationState extends CommonState {
  const TranslationState({this.locale});

  final Locale locale;

  @override
  List<Locale> get props => [locale];
}
