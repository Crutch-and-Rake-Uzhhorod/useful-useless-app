import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/timetable_model.dart';
import '../repository/data_repository.dart';
import '../repository/marker_repository.dart';


//TODO: add status to provide initialization indication in percents
class PowerOffProvider with ChangeNotifier {
  PowerOffProvider({
    required DataRepository dataRepository,
  }) : _dataRepository = dataRepository;

  ///city == 0 => Uzhgorod
  ///city == 1 => Lvov
  ///.....
  int? city = -1;

  final DataRepository _dataRepository;

  final ValueNotifier<bool> loadingStatus = ValueNotifier(false);

  final List<Set<Marker>> _markers = [];

  final List<TimetableModel> _timeTableItems = [];

  UnmodifiableListView<Set<Marker>> get markers =>
      UnmodifiableListView(_markers);

  UnmodifiableListView<TimetableModel> get timetableItems =>
      UnmodifiableListView(_timeTableItems);

  UnmodifiableListView<DateTime> get dates =>
      UnmodifiableListView(_timeTableItems.map((e) => e.timestamp));

  //TODO: think about a case when there are no days available
  //TODO: retrieve list of followed locations(users collection) in order to distinguish locations
  Future<void> init() async {
    loadingStatus.value = true;

    _markers.clear();
    _timeTableItems.clear();

    final rawDates = await _dataRepository.getDates();

    final now = DateTime.now();

    // in case of any error - return empty list with current date
    if (rawDates?.isEmpty ?? true) {
      _markers.add({});
      _timeTableItems.add(TimetableModel.withEmptyLocations(timestamp: now));
      loadingStatus.value = false;
      return;
    }

    // checking for index in order to create list from range [today - 3; end]
    // if there is no today - get last 7 days if possible
    final rawIndexOfToday =
        rawDates!.indexWhere((element) => element.day == now.day);
    final dates = <DateTime>[];

    if (rawIndexOfToday > -1) {
      dates.addAll(
          rawDates.sublist(rawIndexOfToday - 3 > 0 ? rawIndexOfToday - 3 : 0));
    } else {
      dates.addAll(
          rawDates.sublist(rawDates.length >= 7 ? rawDates.length - 7 : 0));
    }

    // first day that will be initialized
    int? firstDateIndexToInit;

    // preset timetable models
    // in case of list will contain info for today - set firstDayToInit
    //ignore: omit_local_variable_types
    for (int i = 0; i < dates.length; i++) {
      if (rawIndexOfToday > -1) {
        if (dates.elementAt(i).day == now.day) {
          firstDateIndexToInit = i;
        }
      }
      _timeTableItems.add(
          TimetableModel.withEmptyLocations(timestamp: dates.elementAt(i)));
      _markers.add({});
    }

    // set firstIndexToInit if list does not contain info for today
    if (firstDateIndexToInit == null) {
      if (dates.last.day < now.day) {
        firstDateIndexToInit = dates.length - 1;
      } else {
        firstDateIndexToInit = 0;
      }
    }

    // set locations for firstIndexToInit
    await _setTimeTableLocations(index: firstDateIndexToInit);

    loadingStatus.value = false;
  }

  Future<void> initFullList() async {
    //ignore: omit_local_variable_types
    for (int i = 0; i < _timeTableItems.length; i++) {
      await _setTimeTableLocations(index: i);
    }
  }

  Future<void> _setTimeTableLocations({required int index}) async {
    loadingStatus.value = true;

    // get locations from DB. in case of error set empty list to avoid it
    final locations = await _dataRepository.getLocationByDay(
            timestamp: _timeTableItems
                .elementAt(index)
                .timestamp
                .millisecondsSinceEpoch) ??
        [];

    // TODO: sort locations so that followed will be first
    // add locations into timetable model
    _timeTableItems.elementAt(index).locations.addAll(locations);

    // create markers from retrieved list
    _markers.elementAt(index).addAll(
          MarkerRepository.createMarkersFromLocations(list: locations),
        );

    notifyListeners();
    loadingStatus.value = false;
  }

  void changeCity({int? chosenCity}) {
    city = chosenCity;
    print(city);
    notifyListeners();
  }

  //consider to replace to google maps controller
  LatLng chosenLatLng({bool isChosenLatLng = false}) {
    //TODO: implement choose of LatLng by user
    // if (isChosenLatLng)
    return LatLng(49.8444851, 23.9660739);
    //TODO: create default Uzhgorod and Lvov centers LatLng markers
    //if(city == 0) return UzhgorodLatitudeLongitude;
    //if(city == 1) return LvovLatitudeLongitude ;
    //notifyListeners();
    // return _markers![2].elementAt(0).position;
  }

  @override
  void dispose() {
    loadingStatus.dispose();
    super.dispose();
  }
}
