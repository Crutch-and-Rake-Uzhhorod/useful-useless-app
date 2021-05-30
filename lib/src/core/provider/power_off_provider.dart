import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  List<Set<Marker>>? _markers;

  List<DateTime>? _dates;

  final ValueNotifier<bool> loadingStatus = ValueNotifier(false);

  UnmodifiableListView<Set<Marker>>? get markers =>
      UnmodifiableListView<Set<Marker>>(_markers!);

  UnmodifiableListView<DateTime>? get dates =>
      UnmodifiableListView<DateTime>(_dates!);

  BitmapDescriptor? _greenIcon;
  BitmapDescriptor? _yellowIcon;
  BitmapDescriptor? _redIcon;

  //TODO: think about a case when there are no days available
  Future<void> init() async {
    loadingStatus.value = true;
    _dates = await _firestoreService.getDates();

    final now = DateTime.now();
    final dayToInit = _dates!.firstWhere(
      (DateTime? date) => date!.day.compareTo(now.day) == 0,
      orElse: () {
        if (_dates!.length > 1) {
          //temporary first. change to actual later
          return _dates!.first;
        } else {
          return _dates!.first;
        }
      },
    );

    final locations = await _firestoreService.getLocationByDay(
        timestamp: dayToInit.millisecondsSinceEpoch);

    _greenIcon ??= await _convertingIconIntoBytes(Colors.green);
    _yellowIcon ??= await _convertingIconIntoBytes(Colors.yellow);
    _redIcon ??= await _convertingIconIntoBytes(Colors.red);

    _markers = [
      locations.map((e) {
        BitmapDescriptor icon;
        //adjust statements
        if (e.frames.first.start.isAtSameMomentAs(now)) {
          icon = _redIcon!;
        } else if (e.frames.first.start.isBefore(now)) {
          icon = _yellowIcon!;
        } else {
          icon = _greenIcon!;
        }

        return Marker(
          markerId: MarkerId(e.houseDetails.geoId),
          position: LatLng(
            e.houseDetails.location.lat,
            e.houseDetails.location.lng,
          ),
          infoWindow: InfoWindow(
              title:
                  '${e.houseDetails.street}\n${e.houseDetails.buildingNumber}'),
          icon: icon,
        );
      }).toSet()
    ];

    loadingStatus.value = false;
  }

  Future<BitmapDescriptor> _convertingIconIntoBytes(Color iconColor) async {
    /// the Icon

    // if(homeSelected){
    //   iconData = Icons.home;
    // } else {
    final iconData = Icons.bolt;
    // }
    /// creating Canvas
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    /// painting previously created Canvas
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    /// expressing icon as a String to be painted
    final iconStr = String.fromCharCode(iconData.codePoint);

    /// customizing the Icon
    textPainter.text = TextSpan(
      text: iconStr,
      style: TextStyle(
        letterSpacing: 0.0,
        fontSize: 100.0,
        fontFamily: iconData.fontFamily,
        color: iconColor,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(0.0, 0.0),
    );

    /// those variables should be here.
    /// don`t touch them unless good code refactor
    ///
    ///
    /// creating picture from Canvas
    final picture = pictureRecorder.endRecording();

    /// converting picture to Image
    final image = await picture.toImage(100, 100);

    /// converting form Image to Bytes
    final bytes = await (image.toByteData(format: ImageByteFormat.png));

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
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
