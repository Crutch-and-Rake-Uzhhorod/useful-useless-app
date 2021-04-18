import 'package:google_maps_flutter/google_maps_flutter.dart';

class MockRepository {
  Future<List<Set<Marker>>> getMarkers({BitmapDescriptor iconForMap}) async {
    return <Set<Marker>>[
      <Marker>{
        Marker(
          markerId: MarkerId('lv1_1'),
          position: LatLng(49.839634, 24.029115),
          infoWindow: InfoWindow(title: 'lwow1'),
          icon: iconForMap,
        ),
        Marker(
          markerId: MarkerId('lv1_@'),
          position: LatLng(49.8444851, 23.9660739),
          infoWindow: InfoWindow(title: 'lwow1'),
          icon: iconForMap,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv2'),
          position: LatLng(49.822597, 24.020339),
          infoWindow: InfoWindow(title: 'lwow2'),
          icon: iconForMap,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv3_1'),
          position: LatLng(49.8347901, 23.9951089),
          infoWindow: InfoWindow(title: 'lwow3'),
          icon: iconForMap,
        ),
        Marker(
          markerId: MarkerId('lv3_2'),
          position: LatLng(49.824806, 23.964032),
          infoWindow: InfoWindow(title: 'lwow3'),
          icon: iconForMap,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv4'),
          position: LatLng(49.7953283, 24.0225477),
          infoWindow: InfoWindow(title: 'lwow4'),
          icon: iconForMap,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv5_1'),
          position: LatLng(49.850887, 24.043659),
          infoWindow: InfoWindow(title: 'lwow5'),
          icon: iconForMap,
        ),
        Marker(
          markerId: MarkerId('lv5_2'),
          position: LatLng(49.823148, 23.980223),
          infoWindow: InfoWindow(title: 'lwow5'),
          icon: iconForMap,
        ),
      }
    ];
  }

  Future<List<DateTime>> getDates() async {
    final now = DateTime.now();
    return <DateTime>[
      now,
      now.add(Duration(days: 1)),
      now.add(Duration(days: 2)),
      now.subtract(Duration(days: 1)),
      now.subtract(Duration(days: 2)),
    ]..sort();
  }
}
