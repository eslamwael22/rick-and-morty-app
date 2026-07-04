import 'package:films_project/Data/web_services/characters_dio.dart';
import 'package:films_project/core/constants/app_routers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RickAndMorty());
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
