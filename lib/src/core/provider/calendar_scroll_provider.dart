import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../repository/date_time_repository.dart';

class CalendarScrollProvider with ChangeNotifier {
  CalendarScrollProvider() {
    _dateTimeRepository = DateTimeRepository();

    _currentDate = DateTime.now();

    fixedExtentScrollController = FixedExtentScrollController(
      initialItem: _index,
    );
  }

  DateTimeRepository _dateTimeRepository;

  int _index = 0;

  DateTime _currentDate;

  List<DateTime> _indexedDates;

  FixedExtentScrollController fixedExtentScrollController;

  int get currentIndex => _index;

  UnmodifiableListView<DateTime> get indexedDates =>
      UnmodifiableListView(_indexedDates);

  int get datesAmount => _indexedDates.length;

  String get selectedMonth => _dateTimeRepository.dateToMonth(
        _indexedDates.elementAt(_index),
      );

  //TODO: implement initialization
  void initDatesList() {
    _indexedDates = <DateTime>[];
    _indexedDates.add(_currentDate);

    // var indexedDatesList = List<Map<String, dynamic>>(numberAmount);
    // for (var index = 0; index <= numberAmount - 1; index++) {
    //   var date = _currentDate.add(Duration(days: index - 20));
    //   var formatter = DateFormat('LLLL');
    //   var month = formatter.format(date);
    //   indexedDatesList[index] = {'date': date, 'day': date.day, 'month': month};
    // }
    // indexedDates = indexedDatesList;
    // return indexedDatesList;
  }

  bool handleScrollNotification(Notification scrollNotification) {
    ///verification of scroll activity
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction == ScrollDirection.idle) {
      log(_index.toString());

      ///item picked in scroll for animation
      fixedExtentScrollController.animateToItem(
        _index,
        duration: Duration(milliseconds: 1000),
        curve: Curves.bounceOut,
      );

      return true;
    }

    return false;
  }

  int achieveCurrentValue(int item) {
    _index = item;

    ///notifyListeners is needed to animate currentItem with scrollController
    notifyListeners();
    return _index;
  }

  @override
  void dispose() {
    fixedExtentScrollController.dispose();
    super.dispose();
  }
}
