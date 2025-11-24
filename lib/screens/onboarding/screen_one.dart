import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/animations/onboarding/expanding_circle_button.dart';
import 'package:task_manager_app_flutter/theme.dart';

class ScreenOne extends StatelessWidget {
  final VoidCallback onNext;

  const ScreenOne({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 118),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ASCEND',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppTheme.primaryOrange,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ultimate Focus & Task Master',
                  style: const TextStyle(
                    color: AppTheme.secondaryLightGray,
                    fontSize: 24,
                  ),
                ),
                const Divider(color: AppTheme.secondaryDarkGray, thickness: 2),
                const SizedBox(height: 32),
              ],
            ),
          ),
          ExpandingCircleButton(onComplete: onNext), // 👈 animation button
        ],
      ),
    );
  }
}
