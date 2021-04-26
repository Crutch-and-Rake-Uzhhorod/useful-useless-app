import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../repository/mock_repository.dart';

//TODO: create list of [LocationModel]

//TODO: add status to provide initialization indication in percents
class PowerOffProvider with ChangeNotifier {
  PowerOffProvider(this._mockRepository) {
    //_mockRepository = MockRepository();
  }

  ///city == 0 => Uzhgorod
  ///city == 1 => Lvov
  ///.....
  int? city = -1;

  final MockRepository? _mockRepository;

  List<Set<Marker>>? _markers;

  List<DateTime>? _dates;

  UnmodifiableListView<Set<Marker>>? get markers =>
      UnmodifiableListView<Set<Marker>>(_markers!);

  UnmodifiableListView<DateTime>? get dates =>
      UnmodifiableListView<DateTime>(_dates!);

  Future<void> init() async {
    //will be replaced with some method which will generate markers and dates from retrieved data
    _markers = await _mockRepository!.getMarkers(
        //TODO: change for real amount of markers
        iconForMap: await _convertingIconIntoBytes());
    _dates = await _mockRepository!.getDates();
  }

  Future<BitmapDescriptor> _convertingIconIntoBytes() async {
    final iconColor = await _getMarkerColor();

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
        fontSize: 72.0,
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
    final image = await picture.toImage(72, 72);

    /// converting form Image to Bytes
    final bytes = await (image.toByteData(format: ImageByteFormat.png));
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  Future<Color>? _getMarkerColor() async {
    //TODO: change variables for more real state
    final colorIndex = await _electricityStatus(index: 2);
    Color? markerColor = Colors.transparent;
    switch (colorIndex) {
      case 0:
        markerColor = Colors.red;
        break;
      case 1:
        markerColor = Colors.yellow;
        break;
      case 2:
        markerColor = Colors.green;
        break;
      default:
        markerColor = Colors.green;
        break;
    }
    return markerColor;
  }

  Future<int> _electricityStatus({required int index}) async {
    final dateTimeNow = DateTime.now();

    final date = await _mockRepository!.getDates();
    //_dates![index!];

    ///if "return 0;" == electricity is down
    ///if "return 1;" == electricity is going to be down
    ///if "return 2;" == electricity was down some time ago
    ///if "return 3;" == no info
//TODO: fix index and dateMock
    if (date[index] == dateTimeNow) return 0;
    if (date[index].isAfter(dateTimeNow)) return 1;
    if (date[index].isBefore(dateTimeNow)) return 2;
    return 3;
  }

  void changeCity({int? chosenCity}) {
    city = chosenCity;
    print(city);
    notifyListeners();
  }

  LatLng chosenLatLng({bool isChosenLatLng = false}) {
    //TODO: implement choose of LatLng by user
    if (isChosenLatLng) return LatLng(49.8444851, 23.9660739);
    //TODO: create default Uzhgorod and Lvov centers LatLng markers
    //if(city == 0) return UzhgorodLatitudeLongitude;
    //if(city == 1) return LvovLatitudeLongitude ;
    //notifyListeners();
    return _markers![2].elementAt(0).position;
  }
}
