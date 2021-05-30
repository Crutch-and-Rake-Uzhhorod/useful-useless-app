import 'package:flutter/material.dart';

import 'loader_item_widget.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 134),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoaderItemWidget(
            color: Colors.purple,
            // size: size.value,
          ),
          SizedBox(
            width: 15,
          ),
          LoaderItemWidget(
            color: Colors.blue,
            millisecondsAnimationDelay: 100,
            //     size: size.value,
          ),
          SizedBox(
            width: 15,
          ),
          LoaderItemWidget(
            color: Colors.lightBlueAccent,
            millisecondsAnimationDelay: 200,
            //     size: size.value,
          ),
          SizedBox(
            width: 15,
          ),
          LoaderItemWidget(
            color: Colors.tealAccent,
            millisecondsAnimationDelay: 300,
            //     size: size.value,
          ),
          SizedBox(
            width: 15,
          ),
          LoaderItemWidget(
            color: Colors.pinkAccent,
            millisecondsAnimationDelay: 400,
            //    size: size.value,
          ),
        ],
      ),
    );
  }
}
