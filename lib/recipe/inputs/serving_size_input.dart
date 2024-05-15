import 'package:formz/formz.dart';

enum ServingSizeValidationError { empty, invalidFormat }

class ServingSizeInput extends FormzInput<String, ServingSizeValidationError> {
  const ServingSizeInput.pure() : super.pure('');

  const ServingSizeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ServingSizeValidationError? validator(String value) {
    if (value.isEmpty) {
      return ServingSizeValidationError.empty;
    }

    RegExp regex = RegExp(r'^\d+(-\d+)?$');

    if (!regex.hasMatch(value)) {
      return ServingSizeValidationError.invalidFormat;
    }

    return null;
  }
}

extension ServingSizeValidationErrorExtension on ServingSizeValidationError {
  String? text() {
    switch (this) {
      case ServingSizeValidationError.empty:
        return 'Serving size cannot be empty';
      case ServingSizeValidationError.invalidFormat:
        return 'Please enter number of servings like 3 or 3-4';
      default:
        return null;
    }
  }
}
