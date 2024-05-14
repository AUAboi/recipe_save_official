import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_save_official/recipe/validators/validator.dart';

part 'recipe_form_validator_state.dart';

class RecipeFormValidatorCubit extends Cubit<RecipeFormValidatorState> {
  RecipeFormValidatorCubit() : super(const RecipeFormValidatorInitial());

  void initForm({
    RecipeNameInput recipeName = const RecipeNameInput.pure(),
    ServingSizeInput servingSize = const ServingSizeInput.pure(),
  }) {
    emit(state.copyWith(
        recipeName: recipeName.value, servingSize: servingSize.value));
  }

  void recipeNameChanged(String value) {
    final recipeName = RecipeNameInput.dirty(value: value);
    emit(state.copyWith(recipeName: recipeName.value));
  }

  void servingSizeChanged(String value) {
    final servingSize = ServingSizeInput.dirty(value: value);
    emit(state.copyWith(servingSize: servingSize.value));
  }
}
