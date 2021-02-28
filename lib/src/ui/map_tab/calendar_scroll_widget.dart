import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../core/provider/calendar_scroll_provider.dart';

class CalendarScrollWidget extends StatelessWidget {
  const CalendarScrollWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Consumer<CalendarScrollProvider>(
            builder: (_, CalendarScrollProvider scrollProvider, __) {
              return Text(
                scrollProvider.selectedMonth,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            width: 320,
            height: 30,
            child: RotatedBox(
              quarterTurns: 3,
              child: Consumer<CalendarScrollProvider>(
                builder: (_, CalendarScrollProvider scrollProvider, __) {
                  return NotificationListener(
                    onNotification: scrollProvider.handleScrollNotification,
                    child: ListWheelScrollView.useDelegate(
                      perspective: 0.00002,
                      squeeze: 1.2,
                      controller: scrollProvider.fixedExtentScrollController,
                      itemExtent: 85,
                      onSelectedItemChanged:
                          scrollProvider.onSelectedDateChanged,
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: scrollProvider.dates.length,
                        builder: (context, index) => RotatedBox(
                          quarterTurns: 1,
                          child: Center(
                            child: Text(
                              '${scrollProvider.dates[index].day}',
                              style: _textStyle(context, index),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _textStyle(
    context,
    index,
  ) {
    final _scrollProvider =
        Provider.of<CalendarScrollProvider>(context, listen: false);
    if (index == _scrollProvider.currentIndex) {
      return Theme.of(context).textTheme.bodyText1.copyWith(
            color: Color.fromRGBO(10, 20, 20, 50),
            fontSize: 26,
            fontWeight: FontWeight.w500,
          );
    } else if (index == _scrollProvider.currentIndex + 1 ||
        index == _scrollProvider.currentIndex - 1) {
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
