import 'package:flutter/material.dart';

import 'loader_item_widget.dart';

class LoaderWidget extends StatelessWidget {
  LoaderWidget({Key? key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
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
