import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class AnimatedBodyWrapper extends StatelessWidget {
  final Widget child;

  const AnimatedBodyWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (
          child,
          animation,
          secondaryAnimation,
          ) =>
          SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          ),
      child: child,
    );
  }
}
