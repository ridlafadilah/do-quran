import 'package:formz/formz.dart';

enum PlaceOfBirthValidationError { empty }

class PlaceOfBirth extends FormzInput<String, PlaceOfBirthValidationError> {
  const PlaceOfBirth.pure([String value = '']) : super.pure(value);
  const PlaceOfBirth.dirty([String value = '']) : super.dirty(value);

  @override
  PlaceOfBirthValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : PlaceOfBirthValidationError.empty;
  }
}
