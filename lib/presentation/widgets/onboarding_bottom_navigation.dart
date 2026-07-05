import 'package:flutter/material.dart';
import 'package:films_project/core/constants/colors.dart';

class OnboardingBottomNavigation extends StatelessWidget {
  final int currentPage;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const OnboardingBottomNavigation({
    super.key,
    required this.currentPage,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'SKIP',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),

        Row(
          children: List.generate(
            3,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index
                    ? AppColors.primaryColor
                    : Colors.grey.shade600,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: onNext,
          child: Row(
            children: [
              Text(
                currentPage == 2 ? 'GET STARTED' : 'NEXT',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward,
                color: AppColors.primaryColor,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
