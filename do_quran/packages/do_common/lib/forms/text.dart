import 'package:formz/formz.dart';

enum TextValidationError { empty, length }

class TextForm extends FormzInput<String, TextValidationError> {
  const TextForm.pure([String value = '']) : super.pure(value);
  const TextForm.dirty([String value = '']) : super.dirty(value);

  @override
  TextValidationError validator(String value) {
    if (value?.isNotEmpty == true) {
      if (value.length >= 5) {
        return null;
      } else {
        return TextValidationError.length;
      }
    } else {
      return TextValidationError.empty;
    }
  }
}
