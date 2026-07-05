import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/onboarding_bottom_navigation.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == 2) {
      context.go('/');
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              OnboardingPage(
                title: 'EXPLORE\nTHE MULTIVERSE',
                subtitle:
                    'Discover every character from\nthe Rick and Morty universe.',
                backgroundColor: Color(0xFF1A1A2E),
                imageAsset: 'assets/images/image1png.png',
              ),
              OnboardingPage(
                title: 'MEET EVERY\nCHARACTER',
                subtitle:
                    'Browse characters with detailed\ninformation and stunning artwork.',
                backgroundColor: Color(0xFF1A1A2E),
                imageAsset: 'assets/images/image2.png',
              ),
              OnboardingPage(
                title: 'READY TO\nEXPLORE?',
                subtitle: 'Start your adventure through\nthe multiverse now.',
                backgroundColor: Color(0xFF1A1A2E),
                imageAsset: 'assets/images/image3.png',
              ),
            ],
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: OnboardingBottomNavigation(
              currentPage: _currentPage,
              onSkip: _skip,
              onNext: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}
