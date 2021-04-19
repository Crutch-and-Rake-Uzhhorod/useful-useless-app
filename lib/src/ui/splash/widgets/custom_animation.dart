import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_ns/liquid_progress_indicator.dart';

class AnimatedLiquidCustomProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCustomProgressIndicatorState();
}

class _AnimatedLiquidCustomProgressIndicatorState
    extends State<AnimatedLiquidCustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return LiquidCustomProgressIndicator(
      value: _animationController.value,
      direction: Axis.vertical,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation(Colors.yellow[800]!),
      shapePath: _buildLightningPath(),
      center: Text(
        '${percentage.toInt()}%',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 18,
            ),
      ),
    );
  }

  static const double initialX = 50;
  static const double initialY = 10;
//TODO: fix lightning coordinates
  Path _buildLightningPath() {
    return Path()
      ..moveTo(initialX, initialY) //initial A coordinates
      ..lineTo(initialX + 55, initialY) //A to B coordinates
      ..lineTo(initialX + 20, initialY + 70) //B to D coordinates
      ..lineTo(initialX + 70, initialY + 70) //D to E coordinates
      ..lineTo(initialX - 30, initialY + 180) //E to F coordinates
      ..lineTo(initialX - 10, initialY + 100) //F to G coordinates
      ..lineTo(initialX - 50, initialY + 100) //G to C coordinates
      ..close(); //C to A coordinates
  }
}
