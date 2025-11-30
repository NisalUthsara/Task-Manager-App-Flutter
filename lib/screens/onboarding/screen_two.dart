import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/screens/todo_screen.dart';
import 'package:task_manager_app_flutter/theme.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryOrange,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 108, 16, 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do less.',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.primaryBlack,
                  ),
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
            Positioned(
              bottom: 40,
              right: 24,
              width: 72,
              height: 72,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(_createRoute());
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryBlack,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Done',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryLightGray,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route<void> _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const TodoScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
