import 'package:formz/formz.dart';

enum SurahFieldValidationError { empty }

class SurahField extends FormzInput<String, SurahFieldValidationError> {
  const SurahField.pure([String value = '']) : super.pure(value);
  const SurahField.dirty([String value = '']) : super.dirty(value);

  @override
  SurahFieldValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : SurahFieldValidationError.empty;
  }
}
