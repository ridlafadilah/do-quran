import 'package:formz/formz.dart';

enum AddressValidationError { empty, length }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure([String value = '']) : super.pure(value);
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError validator(String value) {
    if (value?.isNotEmpty == true) {
      if (value.length >= 5) {
        return null;
      } else {
        return AddressValidationError.length;
      }
    } else {
      return AddressValidationError.empty;
    }
  }
}
