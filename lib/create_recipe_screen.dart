import 'package:flutter/material.dart';
import 'package:recipe_save_official/app_drawer.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateRecipeScreen> {
  final _pages = [const FirstPage(), const SecondPage(), const ThirdPage()];

  late PageController _pageViewController;

  int currentPage = 0;

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
          title: const Text('Create a recipe'),
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
                  value: (currentPage + 1) / _pages.length,
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
                        currentPage = value;
                      });
                    },
                    children: _pages,
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  if (currentPage != 0)
                    TextButton(
                        onPressed: () =>
                            {_updateCurrentPageIndex(currentPage - 1)},
                        child: const Text('Back')),
                  const Spacer(),
                  if (currentPage != _pages.length - 1)
                    TextButton(
                        onPressed: () =>
                            {_updateCurrentPageIndex(currentPage + 1)},
                        child: const Text('Next'))
                ],
              )),
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

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Recipe Name'),
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
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

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
}
