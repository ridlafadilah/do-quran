import 'package:formz/formz.dart';

enum GenderValidationError { empty }

class Gender extends FormzInput<String, GenderValidationError> {
  const Gender.pure([String value = '']) : super.pure(value);
  const Gender.dirty([String value = '']) : super.dirty(value);

  @override
  GenderValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : GenderValidationError.empty;
  }
}
