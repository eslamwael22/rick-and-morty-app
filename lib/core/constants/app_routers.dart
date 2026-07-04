import 'package:films_project/presentation/screens/charcters_screen.dart';
import 'package:films_project/presentation/screens/details_characters_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const CharactersScreen()),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsCharactersScreen(),
    ),
  ],
);
