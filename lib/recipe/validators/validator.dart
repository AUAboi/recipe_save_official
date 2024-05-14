import 'package:formz/formz.dart';

enum RecipeNameValidationError { empty }

class RecipeNameInput extends FormzInput<String, RecipeNameValidationError> {
  const RecipeNameInput.pure() : super.pure('');

  const RecipeNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  RecipeNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : RecipeNameValidationError.empty;
  }
}

enum ServingSizeValidationError { empty }

class ServingSizeInput extends FormzInput<String, ServingSizeValidationError> {
  const ServingSizeInput.pure() : super.pure('');

  const ServingSizeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ServingSizeValidationError? validator(String value) {
    return value.isNotEmpty ? null : ServingSizeValidationError.empty;
  }
}
