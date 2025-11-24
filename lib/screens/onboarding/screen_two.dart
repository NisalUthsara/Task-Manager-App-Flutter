import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/theme.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryOrange,
      body: Center(child: const Text('Screen Two')),
    );
  }
}
