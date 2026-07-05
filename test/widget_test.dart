import 'package:films_project/Business_logic/cubit/characters_cubit.dart';
import 'package:films_project/Data/Repo/characters_repo.dart';
import 'package:films_project/Data/web_services/characters_dio.dart';
import 'package:films_project/presentation/screens/charcters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Characters screen builds without crashing', (tester) async {
    final cubit = CharactersCubit(
      repository: CharactersRepository(CharactersWebService()),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const CharactersScreen()),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
