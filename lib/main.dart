import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_save_official/app_drawer.dart';
import 'package:recipe_save_official/recipe/create_recipe_screen.dart';

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        )
      ],
    ),
    GoRoute(
      path: '/create-recipe',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const CreateRecipeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
  ],
);

void main() {
  runApp(const CookBookApp());
}

class CookBookApp extends StatelessWidget {
  const CookBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange, brightness: Brightness.dark)),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Home Screen',
          style: TextStyle(),
        )),
        drawer: const AppDrawer(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.fastfood_outlined,
                color: Color.fromARGB(221, 142, 142, 142),
                size: 128.0,
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 40.0, right: 40.0),
                  child: Center(
                      child: Text(
                          "Whoops! Seems like you haven't added any food yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(221, 142, 142, 142),
                            fontSize: 18.0,
                          )))),
              const SizedBox(
                height: 6.0,
              ),
              FilledButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.go('/create-recipe');
                },
                label: const Text('Add Now!'),
              )
            ],
          ),
        ));
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}
