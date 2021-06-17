import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:useful_useless_app/src/core/repository/mock_repository.dart';

import '../models/timetable_model.dart';
import '../repository/marker_repository.dart';
import '../services/firestore_service.dart';

//TODO: create list of [LocationModel]

//TODO: add status to provide initialization indication in percents
class PowerOffProvider with ChangeNotifier {
  PowerOffProvider({
    required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  ///city == 0 => Uzhgorod
  ///city == 1 => Lvov
  ///.....
  int? city = -1;

  final FirestoreService _firestoreService;

  final MockRepository _mockRepository = MockRepository();

  //water
  final List<Set<Marker>> _waterMarkers = [];
  final List<TimetableModel> _waterTimetableItems = [];

  final ValueNotifier<bool> loadingStatus = ValueNotifier(false);

  UnmodifiableListView<Set<Marker>> get waterMarkers =>
      UnmodifiableListView<Set<Marker>>(_waterMarkers);

  List<TimetableModel> get waterTimetableItems => _waterTimetableItems;

  UnmodifiableListView<DateTime> get waterDates =>
      UnmodifiableListView<DateTime>(
          _waterTimetableItems.map((e) => e.timestamp));

  //power
  final List<Set<Marker>> _powerMarkers = [];

  final List<TimetableModel> _powerTimetableItems = [];

  UnmodifiableListView<Set<Marker>> get powerMarkers =>
      UnmodifiableListView<Set<Marker>>(_powerMarkers);

  List<TimetableModel> get powerTimetableItems => _powerTimetableItems;

  UnmodifiableListView<DateTime> get powerDates =>
      UnmodifiableListView<DateTime>(
          _powerTimetableItems.map((e) => e.timestamp));

  //TODO: think about a case when there are no days available
  Future<void> init() async {
    loadingStatus.value = true;

    await _initWater();

    final rawDates = await _firestoreService.getDates();

    if (rawDates == null) {
      return;
    }

    final dates = [];

    //ignore: omit_local_variable_types
    for(int i = 0; i < 5; i++){
      dates.add(rawDates.elementAt(i));
    }
    _powerTimetableItems.clear();
    dates
        .forEach((e) => _powerTimetableItems.add(TimetableModel(timestamp: e)));

    _powerMarkers.clear();
    _powerMarkers.addAll( List.generate(_powerTimetableItems.length, (_) => {}));

    final now = DateTime.now();
    final dayIndex = dates.indexOf(dates.firstWhere(
      (date) => date.day.compareTo(now.day) == 0,
      orElse: () {
        if (dates.length > 1) {
          //temporary first. change to actual later
          return dates.first;
        } else {
          return dates.first;
        }
      },
    ));

    await getLocationByDate(dayIndex);

    loadingStatus.value = false;
  }

  Future<void> initFullList() async {
    //ignore: omit_local_variable_types
    for (int i = 0; i < _powerTimetableItems.length; i++) {
      await getLocationByDate(i);
    }
  }

  Future<void> _initWater() async {
    final waterDates = await _mockRepository.getDates();
    _waterTimetableItems.clear();
    waterDates
        .forEach((e) => _waterTimetableItems.add(TimetableModel(timestamp: e)));

    final wMarkers = await _mockRepository.getMarkers(
        iconForMap: MarkerRepository.greenWater);
    _waterMarkers.clear();
    _waterMarkers.addAll(wMarkers);

    // ignore: omit_local_variable_types
    for (int i = 0; i < waterDates.length; i++) {
      final locations = await _mockRepository.getLocationByDay(i);
      _waterTimetableItems.replaceRange(i, i + 1, [
        _waterTimetableItems.elementAt(i).copyWith(locations: locations),
      ]);
    }
  }

  Future<void> getLocationByDate(int dayIndex) async {
    if (_powerTimetableItems.elementAt(dayIndex).locations?.isEmpty ?? true) {
      loadingStatus.value = true;
      final locations = await _firestoreService.getLocationByDay(
        timestamp: _powerTimetableItems
            .elementAt(dayIndex)
            .timestamp
            .millisecondsSinceEpoch,
      );

      _powerTimetableItems.replaceRange(dayIndex, dayIndex + 1, [
        _powerTimetableItems.elementAt(dayIndex).copyWith(locations: locations),
      ]);

      final now = DateTime.now();
      final nowTimestamp = now.millisecondsSinceEpoch;
      _powerMarkers.replaceRange(dayIndex, dayIndex + 1, [
        locations.map((e) {
          BitmapDescriptor icon;
          //adjust statements to hours etc

          //1) if current time is inside time frame
          //2) if power off to be started
          //3) if power off is finished
          if (nowTimestamp >= e.frames.first.start.millisecondsSinceEpoch &&
              nowTimestamp < e.frames.first.end.millisecondsSinceEpoch) {
            icon = MarkerRepository.redIcon;
          } else if (now.isBefore(e.frames.first.start)) {
            icon = MarkerRepository.yellowIcon;
          } else {
            icon = MarkerRepository.greenIcon;
          }

          return Marker(
            //since multiple instances can have same geoId set unique values as street_buildNumber
            markerId: MarkerId(
                '${e.houseDetails.street}_${e.houseDetails.buildingNumber}'),
            position: LatLng(
              e.houseDetails.location.lat,
              e.houseDetails.location.lng,
            ),
            infoWindow: InfoWindow(
                title:
                    'Street: ${e.houseDetails.street}\nBuilding number: ${e.houseDetails.buildingNumber}'),
            icon: icon,
          );
        }).toSet()
      ]);
      notifyListeners();
      loadingStatus.value = false;
    }
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
