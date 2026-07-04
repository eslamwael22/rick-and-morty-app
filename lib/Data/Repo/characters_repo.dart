import 'package:films_project/Data/web_services/characters_dio.dart';
import '../models/characters_model.dart';

class CharactersRepository {
  final CharactersWebService webService;

  CharactersRepository(this.webService);

  Future<List<CharactersModel>> getAllCharacters() async {
    final characters = await webService.getCharacters();

    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }
}
