import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    Key? key,
    this.height = 70.0,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final double height;

  final VoidCallback onTap;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 9),
              blurRadius: 20,
              spreadRadius: 0.1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
