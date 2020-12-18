import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CalendarScrollProvider with ChangeNotifier {

  CalendarScrollProvider(){
    var currentMonth = DateTime.now();
    var formatter = DateFormat('LLLL');
    selectedMonth =  formatter.format(currentMonth);
    indexedDates = getIndexedDates ();
  }

  FixedExtentScrollController fixedExtentScrollController;
  int currentItem = 20;
  int numberAmount = 61;
  int indexStartsFrom = 0;
  String selectedMonth;
  List<Map<String,  dynamic>> indexedDates;



  List<Map<String,  dynamic>> getIndexedDates (){

    //selectedMonth =

    var indexedDatesList = List<Map<String,  dynamic>>(numberAmount);
    for (var index = 0; index <=numberAmount-1; index++ ){
      var date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( days: index-20));
      var formatter = DateFormat('LLLL');
      var month = formatter.format(date);
      indexedDatesList[index]= {
        'date' : date,
        'day' : date.day,
        'month' : month
      };
    }
    indexedDates = indexedDatesList;
    return indexedDatesList;
  }

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
      log(currentItem.toString());
      ///item picked in scroll for animation
      Future.delayed(
        Duration.zero,
            () async {
          if (!isScrollable) return;
          await fixedExtentScrollController.animateToItem(
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
    selectedMonth = indexedDates[item]['month'];
    ///notifyListeners is needed to animate currentItem with scrollController
    notifyListeners();
    return currentItem;
  }
}