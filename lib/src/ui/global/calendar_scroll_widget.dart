import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../core/provider/calendar_scroll_provider.dart';

class CalendarScrollWidget extends StatelessWidget with PreferredSizeWidget {
  const CalendarScrollWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CalendarScrollProvider>(
            builder: (_, CalendarScrollProvider scrollProvider, __) {
              return Text(
                scrollProvider.selectedMonth.toString(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              color: Colors.transparent,
              height: 30,
              alignment: Alignment.center,
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
                          childCount: scrollProvider.dates!.length,
                          builder: (context, index) => RotatedBox(
                            quarterTurns: 1,
                            child: Center(
                              child: Text(
                                '${scrollProvider.dates![index]!.day}',
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
      ),
    );
  }

  TextStyle _textStyle(
    context,
    index,
  ) {
    final themeData = Theme.of(context).textTheme;
    final _scrollProvider =
        Provider.of<CalendarScrollProvider>(context, listen: false);
    if (index == _scrollProvider.currentIndex) {
      return themeData.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      );
    } else if (index == _scrollProvider.currentIndex! + 1 ||
        index == _scrollProvider.currentIndex! - 1) {
      return themeData.bodyText1!.copyWith(
        color: Colors.black.withOpacity(0.5),
        fontSize: 20,
      );
    } else {
      return themeData.bodyText1!.copyWith(
        color: Colors.black.withOpacity(0.3),
        fontSize: 16,
      );
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(130);
}
