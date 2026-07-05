import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final Color backgroundColor;
  final String? imageAsset;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    required this.backgroundColor,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            if (imageAsset != null)
              Expanded(
                flex: 2,
                child: Center(
                  child: SizedBox(
                    // ✅ حجم ثابت لكل الصور، مهما كانت أبعادها الأصلية
                    width: screenWidth * 0.8,
                    height: double.infinity,
                    child: Image.asset(
                      imageAsset!,
                      fit: BoxFit.cover, // ✅ بيحافظ على النسبة الأصلية
                    ),
                  ),
                ),
              ),

            // النصوص
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
