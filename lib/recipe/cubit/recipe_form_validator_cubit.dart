import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../inputs/recipe_name_input.dart';
import '../inputs/serving_size_input.dart';

part 'recipe_form_validator_state.dart';

class RecipeFormValidatorCubit extends Cubit<RecipeFormValidatorState> {
  RecipeFormValidatorCubit() : super(const RecipeFormValidatorInitial());

  void initForm({
    RecipeNameInput recipeName = const RecipeNameInput.pure(),
    ServingSizeInput servingSize = const ServingSizeInput.pure(),
  }) {
    emit(state.copyWith(recipeName: recipeName, servingSize: servingSize));
  }

  void recipeNameChanged(String value) {
    final recipeName = RecipeNameInput.dirty(value: value);
    emit(state.copyWith(recipeName: recipeName));
  }

  void servingSizeChanged(String value) {
    final servingSize = ServingSizeInput.dirty(value: value);
    emit(state.copyWith(servingSize: servingSize));
  }
}
