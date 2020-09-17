import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LatLng _center = const LatLng(48.621025, 22.288229);
  Set<Marker> markers = Set();
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {

    markers.addAll([
      Marker(
          markerId: MarkerId('Uzh'),
          position: LatLng(48.621025, 22.288229),
          infoWindow: InfoWindow( title: "This is  foking Uzhhorod")
      ),
    ]);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('7.Adding Map'),
          backgroundColor: Colors.green[700],
        ),

        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 13.0,
          ),
          markers: markers,
        ),
      ),
    );
  }
}