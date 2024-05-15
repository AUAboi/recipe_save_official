import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_save_official/app_drawer.dart';
import 'package:recipe_save_official/recipe/cubit/recipe_form_validator_cubit.dart';
import 'package:recipe_save_official/recipe/inputs/recipe_name_input.dart';
import 'package:recipe_save_official/recipe/inputs/serving_size_input.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateRecipeScreen> {
  late PageController _pageViewController;

  late final List<StepWidget> _pages = [FirstPage(), SecondPage(), ThirdPage()];

  int _currentPageIndex = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create a recipe"),
        ),
        drawer: const AppDrawer(),
        body: BlocProvider(
            create: (context) => RecipeFormValidatorCubit(),
            child: Container(
                margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: PageView(
                          controller: _pageViewController,
                          physics: const NeverScrollableScrollPhysics(),
                          padEnds: true,
                          onPageChanged: (value) {
                            setState(() {
                              _currentPageIndex = value;
                            });
                          },
                          children: _pages,
                        ),
                      ),
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              _updateCurrentPageIndex(_currentPageIndex - 1);
                            },
                            child: const Text('Back')),
                        TextButton(
                            onPressed: () {
                              if (_pages[_currentPageIndex].validate()) {
                                _updateCurrentPageIndex(_currentPageIndex + 1);
                              }
                            },
                            child: const Text('Next'))
                      ],
                    ))
                  ],
                ))));
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

abstract class StepWidget extends StatelessWidget {
  const StepWidget({super.key});

  bool validate();
}

class FirstPage extends StepWidget {
  FirstPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RecipeFormValidatorCubit, RecipeFormValidatorState>(
            builder: (context, state) {
          return Form(
              key: _formKey,
              child: Column(children: [
                Text(state.recipeName.value),
                TextFormField(
                  initialValue: state.recipeName.value,
                  onChanged: (value) => context
                      .read<RecipeFormValidatorCubit>()
                      .recipeNameChanged(value),
                  decoration: const InputDecoration(labelText: 'Recipe Name'),
                  validator: (value) =>
                      state.recipeName.validator(value ?? '')?.text(),
                ),
                const SizedBox(
                  height: 44.0,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                  ],
                  initialValue: state.servingSize.value,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => context
                      .read<RecipeFormValidatorCubit>()
                      .servingSizeChanged(value),
                  validator: (value) =>
                      state.servingSize.validator(value ?? '')?.text(),
                  decoration: const InputDecoration(
                      labelText: 'Servings', hintText: 'eg. 3-4'),
                )
              ]));
        })
      ],
    );
  }

  @override
  bool validate() {
    return _formKey.currentState!.validate();
  }
}

class SecondPage extends StepWidget {
  SecondPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6.0,
            ),
            const Text(
              'Add Ingredients',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(
              height: 34.0,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Page 2'),
            ),
            const SizedBox(
              height: 34.0,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Servings'),
            )
          ],
        ));
  }

  @override
  bool validate() {
    return _formKey.currentState!.validate();
  }
}

class ThirdPage extends StepWidget {
  ThirdPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Page 3'),
        ),
        const SizedBox(
          height: 34.0,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Servings'),
        )
      ],
    );
  }

  @override
  bool validate() {
    return _formKey.currentState!.validate();
  }
}
