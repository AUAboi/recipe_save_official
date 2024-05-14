import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_save_official/app_drawer.dart';

final pageIndexProvider = StateProvider<int>((ref) => 0);

final formDataProvider = StateProvider<Map<String, String>>((ref) => {
      'recipe_name': '',
      'servings': '',
      'desc': '',
      // Add more form fields as needed
    });

class CreateRecipeScreen extends ConsumerStatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  ConsumerState<CreateRecipeScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateRecipeScreen> {
  late PageController _pageViewController;

  late final List<StepWidget> _pages = [FirstPage(), SecondPage(), ThirdPage()];

  final Map<String, String> formData = {
    'recipe_name': '',
    'serving_size': '',
    'desc': '',
  };

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
    final index = ref.watch(pageIndexProvider);
    StateController<int> counter = ref.watch(pageIndexProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Create a recipe"),
        ),
        drawer: const AppDrawer(),
        body: Container(
          margin: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
                child: LinearProgressIndicator(
                  value: (index + 1) / _pages.length,
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 10,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: PageView(
                    controller: _pageViewController,
                    physics: const NeverScrollableScrollPhysics(),
                    padEnds: true,
                    onPageChanged: (value) {
                      setState(() {
                        counter.state = value;
                      });
                    },
                    children: _pages,
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        if (_pages[index].validate())
                          _updateCurrentPageIndex(index - 1);
                      },
                      child: const Text('Back')),
                  TextButton(
                      onPressed: () {
                        _updateCurrentPageIndex(index + 1);
                      },
                      child: const Text('Next'))
                ],
              ))
            ],
          ),
        ));
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

abstract class StepWidget extends ConsumerWidget {
  const StepWidget({super.key});

  bool validate();
}

class FirstPage extends StepWidget {
  FirstPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(formDataProvider.notifier);

    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) => formData.state['recipe_name'] = value,
              decoration: const InputDecoration(labelText: 'Recipe Name'),
            ),
            const SizedBox(
              height: 34.0,
            ),
            TextFormField(
              onChanged: (value) => formData.state['serving_size'] = value,
              decoration: const InputDecoration(
                  labelText: 'Servings', hintText: 'eg. 3-4'),
            )
          ],
        ));
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
    );
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
  Widget build(BuildContext context, WidgetRef ref) {
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
