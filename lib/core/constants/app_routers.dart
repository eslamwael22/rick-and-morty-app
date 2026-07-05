import 'package:films_project/Business_logic/cubit/characters_cubit.dart';
import 'package:films_project/Data/Repo/characters_repo.dart';
import 'package:films_project/Data/web_services/characters_dio.dart';
import 'package:films_project/presentation/screens/charcters_screen.dart';
import 'package:films_project/presentation/screens/details_characters_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => CharactersCubit(
          repository: CharactersRepository(CharactersWebService()),
        )..fetchCharacters(),
        child: const CharactersScreen(),
      ),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsCharactersScreen(),
    ),
  ],
);
