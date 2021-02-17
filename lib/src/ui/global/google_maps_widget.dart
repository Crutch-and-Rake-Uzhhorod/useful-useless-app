import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget GoogleMapsWidget() {
  var markers = <Marker>{};
  final _center = const LatLng(48.621025, 22.288229);

  markers.addAll(
    [
      Marker(
          markerId: MarkerId('Uzh'),
          position: LatLng(48.621025, 22.288229),
          infoWindow: InfoWindow(title: 'This is foking Uzhhorod')),
    ],
  );

  return GoogleMap(
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 13.0,
    ),
    markers: markers,
  );
}
