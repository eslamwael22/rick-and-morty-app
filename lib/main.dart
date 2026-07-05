import 'package:films_project/core/constants/app_routers.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RickAndMorty());
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        primaryColor: const Color(0xFF1A1A2E),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router, // ✅ لازم .router مع GoRouter
    );
  }
}
