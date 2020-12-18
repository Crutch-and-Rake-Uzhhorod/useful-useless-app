import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomScrollProvider with ChangeNotifier {
  FixedExtentScrollController fixedExtentScrollController;
  int currentItem = 2;
  int numberAmount = 52;
  int indexStartsFrom = 18;

  FixedExtentScrollController initializeScrollController() {
    return fixedExtentScrollController = FixedExtentScrollController(
      initialItem: currentItem,
    );
  }

  bool handleScrollNotification(scrollNotification) {
    ///verification of scroll activity
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction == ScrollDirection.idle) {
      final isScrollable = true;

      ///item picked in scroll for animation
      Future.delayed(
        Duration.zero,
            () async {
          if (!isScrollable) return;
          await FixedExtentScrollController().animateToItem(
              currentItem,
              duration: Duration(milliseconds: 1000),
              curve: Curves.bounceOut,
            );
        },
      );
    }
    return false;
  }

  int achieveCurrentValue(int item) {
    currentItem = item;

    ///notifyListeners is needed to animate currentItem with scrollController
    notifyListeners();
    return currentItem;
  }
}