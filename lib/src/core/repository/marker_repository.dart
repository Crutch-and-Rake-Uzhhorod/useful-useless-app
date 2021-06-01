import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerRepository {
  static BitmapDescriptor? _greenIcon;
  static BitmapDescriptor? _yellowIcon;
  static BitmapDescriptor? _redIcon;

  static BitmapDescriptor? get greenIcon => _greenIcon;

  static BitmapDescriptor? get yellowIcon => _yellowIcon;

  static BitmapDescriptor? get redIcon => _redIcon;

  static Future<void> initMarkerIcons() async {
    _greenIcon ??= await _convertingIconIntoBytes(Colors.green);
    _yellowIcon ??= await _convertingIconIntoBytes(Colors.yellow);
    _redIcon ??= await _convertingIconIntoBytes(Colors.red);
  }

  static Future<BitmapDescriptor> _convertingIconIntoBytes(
      Color iconColor) async {
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
}