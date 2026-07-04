import 'dart:developer';
import 'package:dio/dio.dart';

class CharactersWebService {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  Future<List<dynamic>> getCharacters() async {
    try {
      final response = await dio.get('/character');

      return response.data['results'];
    } on DioException catch (e) {
      log(e.message.toString());
      return [];
    }
  }
}
