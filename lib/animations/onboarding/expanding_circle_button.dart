import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/theme.dart';
import 'dart:math';

class ExpandingCircleButton extends StatefulWidget {
  final VoidCallback onComplete;

  const ExpandingCircleButton({super.key, required this.onComplete});

  @override
  State<ExpandingCircleButton> createState() => _ExpandingCircleButtonState();
}

class _ExpandingCircleButtonState extends State<ExpandingCircleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

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
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final double maxDimensions =
        sqrt(pow(screenSize.width, 2) + pow(screenSize.height, 2)) * 2;

    _sizeAnimation = Tween<double>(
      begin: buttonSize,
      end: maxDimensions,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3)),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: buttonBottom,
          right: buttonRight,
          width: buttonSize,
          height: buttonSize,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return OverflowBox(
                maxWidth: maxDimensions,
                maxHeight: maxDimensions,
                minWidth: 0,
                minHeight: 0,
                child: GestureDetector(
                  onTap: _handleTap,
                  child: Container(
                    width: _sizeAnimation.value,
                    height: _sizeAnimation.value,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryOrange,
                    ),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
