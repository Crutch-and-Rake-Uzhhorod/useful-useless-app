import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../repository/mock_repository.dart';

//TODO: create list of [LocationModel]

//TODO: add status to provide initialization indication in percents
class PowerOffProvider with ChangeNotifier {
  PowerOffProvider() {
    _mockRepository = MockRepository();
  }

  MockRepository _mockRepository;

  List<Set<Marker>> _markers;

  List<DateTime> _dates;

  UnmodifiableListView<Set<Marker>> get markers =>
      UnmodifiableListView<Set<Marker>>(_markers);

  UnmodifiableListView<DateTime> get dates =>
      UnmodifiableListView<DateTime>(_dates);

  Future<void> init() async {
    //will be replaced with some method which will generate markers and dates from retrieved data
    _markers = await _mockRepository.getMarkers(
        iconForMap: await _convertingIconIntoBytes());
    _dates = await _mockRepository.getDates();
  }

  Future<BitmapDescriptor> _convertingIconIntoBytes() async {
    /// the Icon
    final iconData = Icons.bolt;

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
        color: _getMarkerColor(),
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
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  Color _getMarkerColor() {
    //TODO: change variables for more real state

    final soonTurnOff = false;
    final alreadyTurnedOff = true;
    final electricityExist = false;
    if (electricityExist) {
      return Colors.green;
    } else if (soonTurnOff) {
      return Colors.yellow;
    } else if (alreadyTurnedOff) {
      return Colors.red;
    }
    return Colors.green;
  }
}
