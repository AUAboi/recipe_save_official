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

extension RecipeNameValidationErrorExtension on RecipeNameValidationError {
  String text() {
    switch (this) {
      case RecipeNameValidationError.empty:
        return 'Please enter a name for this recipe';
    }
  }
}
