import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../repository/date_time_repository.dart';

class CalendarScrollProvider with ChangeNotifier {
  CalendarScrollProvider({
    @required UnmodifiableListView<DateTime> dates,
  }) {
    _dateTimeRepository = DateTimeRepository();

    _currentDate = DateTime.now();

    _dates = dates ?? <DateTime>[_currentDate];

    _index = _dates.indexOf(
      _dates.firstWhere(
        (DateTime date) => date.day.compareTo(_currentDate.day) == 0,
        orElse: () {
          if (_dates.length > 1) {
            return _dates.elementAt((_dates.length / 2).ceil());
          } else {
            return _dates.first;
          }
        },
      ),
    );

    fixedExtentScrollController = FixedExtentScrollController(
      initialItem: _index,
    );
  }

  DateTimeRepository _dateTimeRepository;

  FixedExtentScrollController fixedExtentScrollController;

  DateTime _currentDate;

  UnmodifiableListView<DateTime> _dates;

  int _index;

  UnmodifiableListView<DateTime> get dates => _dates;

  String get selectedMonth => _dateTimeRepository.dateToMonth(
        _dates.elementAt(_index),
      );

  int get currentIndex => _index;

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
              fixedExtentScrollController.animateToItem(
            _index,
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
    fixedExtentScrollController.dispose();
    super.dispose();
  }
}
