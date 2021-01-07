import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomTransitionsBuilders {
  CustomTransitionsBuilders._();

  static const horizontalSharedAxisTransition = _horizontalSharedAxisTransition;

  static Widget _horizontalSharedAxisTransition(
    BuildContext _,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SharedAxisTransition(
      child: child,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
    );
  }
}
