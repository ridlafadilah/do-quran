import 'package:formz/formz.dart';

enum DateOfBirthValidationError { empty }

class DateOfBirth extends FormzInput<String, DateOfBirthValidationError> {
  const DateOfBirth.pure([String value = '']) : super.pure(value);
  const DateOfBirth.dirty([String value = '']) : super.dirty(value);

  @override
  DateOfBirthValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : DateOfBirthValidationError.empty;
  }
}
