import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../repository/date_time_repository.dart';

//add callback as listener

class CalendarScrollProvider with ChangeNotifier {
  CalendarScrollProvider({
    UnmodifiableListView<DateTime>? dates,
  }) {
    _currentDate = DateTime.now();

    _dates = (dates ?? <DateTime?>[_currentDate])
        as UnmodifiableListView<DateTime?>?;

    _index = _dates!.indexOf(
      _dates!.firstWhere(
          (DateTime? date) => date!.day.compareTo(_currentDate!.day) == 0,
          orElse: () {
        if (_dates!.length > 1) {
          // return _dates!.elementAt((_dates!.length / 2).ceil())!;
          //temporary first. change to actual later
          return _dates!.first!;
        } else {
          return _dates!.first!;
        }
      }),
    );

    fixedExtentScrollController = FixedExtentScrollController(
      initialItem: _index!,
    );
  }

  FixedExtentScrollController? fixedExtentScrollController;

  DateTime? _currentDate;

  UnmodifiableListView<DateTime?>? _dates;

  int? _index;

  UnmodifiableListView<DateTime?>? get dates => _dates;

  String get selectedMonth => DateTimeRepository.dateToMonth(
        _dates!.elementAt(_index!)!,
      );

  int? get currentIndex => _index;

  bool handleScrollNotification(Notification scrollNotification) {
    ///verification of scroll activity
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction == ScrollDirection.idle) {
      log(_index.toString());
      final isScrollable = true;
      Future.delayed(
        Duration.zero,
        () async {
          if (!isScrollable) return;
          await

              ///item picked in scroll for animation
              fixedExtentScrollController!.animateToItem(
            _index!,
            duration: Duration(milliseconds: 1000),
            curve: Curves.bounceOut,
          );
        },
      );
    }
    return false;
  }

  void onSelectedDateChanged(int item) {
    _index = item;

    ///notifyListeners is needed to animate currentItem with scrollController
    notifyListeners();
  }

  @override
  void dispose() {
    fixedExtentScrollController!.dispose();
    super.dispose();
  }
}
