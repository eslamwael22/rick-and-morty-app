import 'package:bloc/bloc.dart';
import 'package:films_project/Data/Repo/characters_repo.dart';
import 'package:films_project/Data/models/characters_model.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository repository;
  Future<void> fetchCharacters() async {
    emit(CharactersLoading());
    try {
      final characters = await repository.getAllCharacters();
      emit(CharactersLoaded(characters));
    } catch (e) {
      print('Error fetching characters: $e');
    }
  }

  CharactersCubit({required this.repository}) : super(CharactersInitial());
}
