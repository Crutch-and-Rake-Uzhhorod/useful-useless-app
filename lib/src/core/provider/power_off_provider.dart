import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final ValueNotifier<bool> loadingStatus = ValueNotifier(false);

  final List<Set<Marker>> _markers = [];

  final List<TimetableModel> _timeTableItems = [];

  UnmodifiableListView<Set<Marker>> get markers =>
      UnmodifiableListView<Set<Marker>>(_markers);

  List<TimetableModel> get timetableItems => _timeTableItems;

  UnmodifiableListView<DateTime> get dates =>
      UnmodifiableListView<DateTime>(
          _timeTableItems.map((e) => e.timestamp));

  //TODO: think about a case when there are no days available
  Future<void> init() async {
    loadingStatus.value = true;

    final dates = await _firestoreService.getDates();

    if (dates == null) {
      return;
    }

    _timeTableItems.clear();
    dates
        .forEach((e) => _timeTableItems.add(TimetableModel(timestamp: e)));

    _markers.clear();
    _markers.addAll(List.generate(_timeTableItems.length, (_) => {}));

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
    for (int i = 0; i < _timeTableItems.length; i++) {
      await getLocationByDate(i);
    }
  }

  Future<void> getLocationByDate(int dayIndex) async {
    if (_timeTableItems.elementAt(dayIndex).locations?.isEmpty ?? true) {
      loadingStatus.value = true;
      final locations = await _firestoreService.getLocationByDay(
        timestamp: _timeTableItems
            .elementAt(dayIndex)
            .timestamp
            .millisecondsSinceEpoch,
      );

      _timeTableItems.replaceRange(dayIndex, dayIndex + 1, [
        _timeTableItems.elementAt(dayIndex).copyWith(locations: locations),
      ]);

      final now = DateTime.now();
      final nowTimestamp = now.millisecondsSinceEpoch;
      _markers.replaceRange(dayIndex, dayIndex + 1, [
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
