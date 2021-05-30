import 'package:flutter/material.dart';

class LoaderItemWidget extends StatefulWidget {
  LoaderItemWidget({
    this.color,
    this.millisecondsAnimationDelay = 0,
  });
  final Color? color;
  final int millisecondsAnimationDelay;

  @override
  _LoaderItemWidgetState createState() => _LoaderItemWidgetState();
}

class _LoaderItemWidgetState extends State<LoaderItemWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> itemScaleAnimation;
  late Animation<double> blurRadiusAnimation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      value: 0.5,
    );
    itemScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    blurRadiusAnimation = Tween<double>(begin: 0, end: 10).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    Future.delayed(Duration(milliseconds: widget.millisecondsAnimationDelay),
        () {
      if (mounted) {
        controller
          ..forward()
          ..repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: itemScaleAnimation,
      child: Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: widget.color!,
              offset: Offset(0, 0),
              blurRadius: blurRadiusAnimation.value,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
