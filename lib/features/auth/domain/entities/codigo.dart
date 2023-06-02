import 'package:formz/formz.dart';

enum CodigoValidationError { invalid }

class Codigo extends FormzInput<String, CodigoValidationError> {
  const Codigo.pure() : super.pure('');
  const Codigo.dirty([super.value = '']) : super.dirty();

  @override
  CodigoValidationError? validator(String value) {
    return isNumeric(value) || value.isEmpty ? null : CodigoValidationError.invalid;
  }
}

extension Explanation on CodigoValidationError {
  String? get nome {
    switch (this) {
      case CodigoValidationError.invalid:
        return 'Codigo inválido';
    }
  }
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
