import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/calendar_scroll_provider.dart';

class CalendarScrollWebWidget extends StatelessWidget {
  const CalendarScrollWebWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
        ),
        color: const Color(0xff2F4047),
      ),
      child: Column(
        children: [
          Consumer<CalendarScrollProvider>(
            builder: (_, CalendarScrollProvider scrollProvider, __) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  scrollProvider.selectedMonth.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              alignment: Alignment.topCenter,
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
                            child: Text(
                              '${scrollProvider.dates![index]!.day}',
                              style: _textStyle(context, index),
                              textAlign: TextAlign.center,
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
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      );
    } else if (index == _scrollProvider.currentIndex! + 1 ||
        index == _scrollProvider.currentIndex! - 1) {
      return themeData.bodyText1!.copyWith(
        color: Colors.white.withOpacity(0.5),
        fontSize: 22,
      );
    } else {
      return themeData.bodyText1!.copyWith(
        color: Colors.white.withOpacity(0.3),
        fontSize: 18,
      );
    }
  }
}
