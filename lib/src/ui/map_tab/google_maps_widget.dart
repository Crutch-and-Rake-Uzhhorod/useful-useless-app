import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'calendar_scroll_widget.dart';

class GoogleMapsWidget extends StatelessWidget {
  final LatLng _center = const LatLng(48.621025, 22.288229);

  //temp marker
  //TODO: rework with power_off_provider
  final Set<Marker> markers = <Marker>{
    Marker(
      markerId: MarkerId('Uzh'),
      position: LatLng(48.621025, 22.288229),
      infoWindow: InfoWindow(title: 'This is foking Uzhhorod'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CalendarScrollWidget(),
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: markers,
          ),
        )
      ],
    );
  }
}
