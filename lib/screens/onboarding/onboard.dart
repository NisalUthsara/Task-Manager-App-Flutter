import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/screens/onboarding/screen_one.dart';
import 'package:task_manager_app_flutter/screens/onboarding/screen_two.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextPage() {
    _controller.animateToPage(
      1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              ScreenOne(onNext: nextPage),
              const ScreenTwo(),
            ],
          ),
        ],
      ),
    );
  }
}
