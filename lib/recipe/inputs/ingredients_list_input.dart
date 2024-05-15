import 'package:formz/formz.dart';
import 'package:recipe_save_official/recipe/models/ingredients.dart'; // Assuming Ingredient model is defined here

enum IngredientsListValidationError { empty, invalidIngredient }

class IngredientsListInput
    extends FormzInput<List<Ingredient>, IngredientsListValidationError> {
  IngredientsListInput.pure() : super.pure([]);

  const IngredientsListInput.dirty({List<Ingredient> value = const []})
      : super.dirty(value);

  @override
  IngredientsListValidationError? validator(List<Ingredient> value) {
    if (value.isEmpty) {
      return IngredientsListValidationError.empty;
    }

    for (var ingredient in value) {
      if (ingredient.name.isEmpty || ingredient.quantity <= 0) {
        return IngredientsListValidationError.invalidIngredient;
      }
    }

    return null;
  }
}

extension IngredientsListValidationErrorExtension
    on IngredientsListValidationError {
  String text() {
    switch (this) {
      case IngredientsListValidationError.empty:
        return 'Please enter at least one ingredient';
      case IngredientsListValidationError.invalidIngredient:
        return 'Please enter valid information for all ingredients';
    }
  }
}
