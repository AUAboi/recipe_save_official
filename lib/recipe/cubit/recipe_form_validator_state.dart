part of 'recipe_form_validator_cubit.dart';

@immutable
sealed class RecipeFormValidatorState {
  final AutovalidateMode autovalidateMode;
  final String recipeName;
  final String servingSize;

  const RecipeFormValidatorState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.recipeName = '',
    this.servingSize = '',
  });

  RecipeFormValidatorState copyWith({
    AutovalidateMode? autovalidateMode,
    String? recipeName,
    String? servingSize,
  });
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
    String? recipeName,
    String? servingSize,
  }) {
    return RecipeFormValidatorInitial(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      recipeName: recipeName ?? this.recipeName,
      servingSize: servingSize ?? this.servingSize,
    );
  }
}
