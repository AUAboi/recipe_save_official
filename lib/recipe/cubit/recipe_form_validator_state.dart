part of 'recipe_form_validator_cubit.dart';

@immutable
class RecipeFormValidatorState {
  final AutovalidateMode autovalidateMode;
  final RecipeNameInput recipeName;
  final ServingSizeInput servingSize;

  const RecipeFormValidatorState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.recipeName = const RecipeNameInput.pure(),
    this.servingSize = const ServingSizeInput.pure(),
  });

  RecipeFormValidatorState copyWith({
    AutovalidateMode? autovalidateMode,
    RecipeNameInput? recipeName,
    ServingSizeInput? servingSize,
  }) {
    return RecipeFormValidatorState(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      recipeName: recipeName ?? this.recipeName,
      servingSize: servingSize ?? this.servingSize,
    );
  }
}

final class RecipeFormValidatorInitial extends RecipeFormValidatorState {
  const RecipeFormValidatorInitial({
    super.autovalidateMode,
    super.recipeName,
    super.servingSize,
  });

  @override
  RecipeFormValidatorInitial copyWith({
    AutovalidateMode? autovalidateMode,
    RecipeNameInput? recipeName,
    ServingSizeInput? servingSize,
  }) {
    return RecipeFormValidatorInitial(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      recipeName: recipeName ?? this.recipeName,
      servingSize: servingSize ?? this.servingSize,
    );
  }
}
