import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:useful_useless_app/src/core/provider/custom_scroll_provider.dart';



class CustomPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<CustomScrollProvider>(context);
    return RotatedBox(
      quarterTurns: 3,
      child: NotificationListener(
        onNotification: (onNotification) =>
            scrollProvider.handleScrollNotification(onNotification),
        child: ListWheelScrollView.useDelegate(
          perspective: 0.00002,
          squeeze: 1.2,
          controller: scrollProvider.initializeScrollController(),
          itemExtent: 85,
          onSelectedItemChanged: (item) =>
              scrollProvider.achieveCurrentValue(item),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: scrollProvider.numberAmount,
            builder: (context, index) => RotatedBox(
              quarterTurns: 1,
              child: Center(
                child: Text(
                  '${index + scrollProvider.indexStartsFrom}',
                  style: _textStyle(context, index),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(
      context,
      index,
      ) {
    final _scrollProvider =
    Provider.of<CustomScrollProvider>(context, listen: false);
    if (index == _scrollProvider.currentItem) {
      return Theme.of(context).textTheme.bodyText1.copyWith(
        color: Color.fromRGBO(10, 20, 20, 50),
        fontSize: 26,
        fontWeight: FontWeight.w500,
      );
    } else if (index == _scrollProvider.currentItem + 1 ||
        index == _scrollProvider.currentItem - 1) {
      return Theme.of(context).textTheme.bodyText1.copyWith(
        color: Color.fromRGBO(50, 50, 50, 90),
        fontSize: 22,
      );
    } else {
      return Theme.of(context).textTheme.bodyText1.copyWith(
        color: Color.fromRGBO(10, 70, 70, 80),
        fontSize: 18,
      );
    }
  }
}