import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// بيتفتكر إذا كان المستخدم شاف الـ Onboarding أثناء تشغيل التطبيق
class AppState {
  static bool hasSeenOnboarding = false;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (AppState.hasSeenOnboarding) {
      context.go('/');
    } else {
      AppState.hasSeenOnboarding = true;
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash.png',
                width: 180,
                height: 200,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 24),

              const Text(
                'Explore Infinite Dimensions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
