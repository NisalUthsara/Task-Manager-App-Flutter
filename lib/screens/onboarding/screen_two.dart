import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/theme.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryOrange,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 118),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do less.',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppTheme.primaryBlack),
            ),
            Text(
              'Achieve more.',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.secondaryLightGray,
                fontSize: 52,
              ),
            ),
            const SizedBox(height: 84),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Ascend is the first task manager designed to work with your brain, not against it. Stop managing tasks and start ascending',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryLightGray,
                    ),
                    textDirection: TextDirection.rtl,
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
