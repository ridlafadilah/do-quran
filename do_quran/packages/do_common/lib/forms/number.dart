import 'package:formz/formz.dart';

enum NumberValidationError { invalid }

class Number extends FormzInput<String, NumberValidationError> {
  const Number.pure([String value = '', this.length = 0]) : super.pure(value);
  const Number.dirty([String value = '', this.length = 0]) : super.dirty(value);

  static final RegExp _numberRegExp = RegExp(
    r'^[0-9]+$',
  );

  final int length;

  @override
  NumberValidationError validator(String value) {
    if (_numberRegExp.hasMatch(value)) {
      if (length > 0) {
        if (value.length >= length) {
          return null;
        } else {
          return NumberValidationError.invalid;
        }
      } else {
        return null;
      }
    } else {
      return NumberValidationError.invalid;
    }
  }
}
