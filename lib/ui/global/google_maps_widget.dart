import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'custom_scroll_widget.dart';
class GoogleMapsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var markers = <Marker>{};
    final _center = const LatLng(48.621025, 22.288229);

    markers.addAll([
      Marker(
          markerId: MarkerId('Uzh'),
          position: LatLng(48.621025, 22.288229),
          infoWindow: InfoWindow( title: 'This is foking Uzhhorod')
      ),
    ]);

    return Column(
        children: <Widget>[
          Container(
            height: 150,
            child: CustomPicker()
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,  // or use fixed size like 200
              height: MediaQuery.of(context).size.height-300,
              child:  GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 13.0,
                ),
                markers: markers,
              )
          )
        ]);
  }
}