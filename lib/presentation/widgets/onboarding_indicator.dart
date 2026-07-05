import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentPage;

  const OnboardingIndicator({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(3, (index) => Container()));
  }
}
