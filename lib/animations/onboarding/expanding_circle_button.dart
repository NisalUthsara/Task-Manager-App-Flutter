import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/theme.dart';

class ExpandingCircleButton extends StatefulWidget {
  final VoidCallback onComplete;

  const ExpandingCircleButton({super.key, required this.onComplete});

  @override
  State<ExpandingCircleButton> createState() => _ExpandingCircleButtonState();
}

class _ExpandingCircleButtonState extends State<ExpandingCircleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _startAnimation = false;

  // Button properties
  static const double buttonSize = 72.0; // Total button size (padding + icon)
  static const double buttonBottom = 40.0;
  static const double buttonRight = 24.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: buttonSize,
      end: 3000,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() => _startAnimation = true);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_startAnimation)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final circleSize = _animation.value;
              // Calculate how much to offset to keep circle centered on button
              final offset = (circleSize - buttonSize) / 2;

              return Positioned(
                bottom: buttonBottom - offset,
                right: buttonRight - offset,
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryOrange,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        if (!_startAnimation)
          Positioned(
            bottom: buttonBottom,
            right: buttonRight,
            child: ElevatedButton(
              onPressed: _handleTap,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                backgroundColor: AppTheme.primaryOrange,
                elevation: 8,
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 32,
                color: AppTheme.secondaryLightGray,
              ),
            ),
          ),
      ],
    );
  }
}
