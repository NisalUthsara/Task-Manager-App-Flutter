import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/theme.dart';

class ScreenOne extends StatelessWidget {
  final VoidCallback onNext;

  const ScreenOne({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 58),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Ascend',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(color: AppTheme.primaryOrange),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Ultimate Focus & Task Master',
                  style: TextStyle(
                    color: AppTheme.secondaryLightGray,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            Divider(color: AppTheme.secondaryDarkGray, thickness: 2),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: AppTheme.primaryOrange,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 32,
                    color: AppTheme.secondaryLightGray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
