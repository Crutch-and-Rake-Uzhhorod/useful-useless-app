import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/frame_model.dart';

class MarkerRepository {
  static late final BitmapDescriptor _greenIcon;
  static late final BitmapDescriptor _yellowIcon;
  static late final BitmapDescriptor _redIcon;

  static BitmapDescriptor get greenIcon => _greenIcon;

  static BitmapDescriptor get yellowIcon => _yellowIcon;

  static BitmapDescriptor get redIcon => _redIcon;

  static Future<void> initMarkerIcons() async {
    _greenIcon = await _convertingIconIntoBytes(Colors.green);
    _yellowIcon = await _convertingIconIntoBytes(Colors.yellow);
    _redIcon = await _convertingIconIntoBytes(Colors.red);
  }

  static Future<BitmapDescriptor> _convertingIconIntoBytes(
    Color iconColor,
  ) async {
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

  static Set<Marker> createMarkersFromLocations({required List<FrameModel> list}) {
    final now = DateTime.now();
    final nowTimestamp = now.millisecondsSinceEpoch;

    return list.map((e) {
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
    }).toSet();
  }
}
