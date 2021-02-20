import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class AnimatedLiquidCustomProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCustomProgressIndicatorState();
}

class _AnimatedLiquidCustomProgressIndicatorState
    extends State<AnimatedLiquidCustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });

    _animationController.forward();
    //_animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: LiquidCustomProgressIndicator(
        value: _animationController.value,
        direction: Axis.vertical,
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.yellow[800]),
        shapePath: _buildHeartPath(),
        center: Text(
          '${percentage.toInt()}%',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  static const double initialX = 55;
  static const double initialY = 5;

  Path _buildHeartPath() {
    return Path()
      ..moveTo(initialX, initialY) //initial A coordinates
      ..lineTo(initialX + 60, initialY) //A to B coordinates
      ..lineTo(initialX + 20, initialY + 60) //B to D coordinates
      ..lineTo(initialX + 60, initialY + 60) //D to E coordinates
      ..lineTo(initialX - 30, initialY + 170) //E to F coordinates
      ..lineTo(initialX - 10, initialY + 90) //F to G coordinates
      ..lineTo(initialX - 50, initialY + 90) //G to C coordinates
      ..close(); //C to A coordinates
  }
}
