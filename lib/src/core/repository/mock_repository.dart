import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/frame_model.dart';
import '../models/house_details_model.dart';
import '../models/location_coordinates.dart';
import '../models/time_frame_model.dart';
import 'marker_repository.dart';

class MockRepository {
  // remove parameter and set icons manually
  // for maps screen.
  Future<List<Set<Marker>>> getMarkers({
    required BitmapDescriptor iconForMap,
  }) async {
    return <Set<Marker>>[
      <Marker>{
        Marker(
          markerId: MarkerId('lv1_1'),
          position: LatLng(49.839634, 24.029115),
          infoWindow: InfoWindow(title: 'вул.Свободи, 1'),
          icon: MarkerRepository.greenIcon,
        ),
        Marker(
          markerId: MarkerId('lv1_@'),
          position: LatLng(49.8444851, 23.9660739),
          infoWindow: InfoWindow(title: 'вул.Івана Сірка, 10'),
          icon: MarkerRepository.redIcon,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv2'),
          position: LatLng(49.822597, 24.020339),
          infoWindow: InfoWindow(title: 'вул.Стрийска, 48'),
          icon: MarkerRepository.redIcon,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv3_1'),
          position: LatLng(49.8347901, 23.9951089),
          infoWindow: InfoWindow(title: 'вул.Смол-Стоцького, 1'),
          icon: MarkerRepository.redIcon,
        ),
        Marker(
          markerId: MarkerId('lv3_2'),
          position: LatLng(49.824806, 23.964032),
          infoWindow: InfoWindow(title: 'вул.Полтави, 53'),
          icon: MarkerRepository.redIcon,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv4'),
          position: LatLng(49.7953283, 24.0225477),
          infoWindow: InfoWindow(title: 'вул.Михайла Максимовича, 9А'),
          icon: MarkerRepository.yellowIcon,
        ),
      },
      <Marker>{
        Marker(
          markerId: MarkerId('lv5_1'),
          position: LatLng(49.850887, 24.043659),
          infoWindow: InfoWindow(title: 'вул.Кордуби, 2'),
          icon: MarkerRepository.yellowIcon,
        ),
        Marker(
          markerId: MarkerId('lv5_2'),
          position: LatLng(49.823148, 23.980223),
          infoWindow: InfoWindow(title: 'вул.Садова, 11Б'),
          icon: MarkerRepository.yellowIcon,
        ),
      }
    ];
  }

  //for scroll. has to be same length as "collections" in getLocationsByDay
  Future<List<DateTime>> getDates() async {
    return <DateTime>[
      DateTime(2021, 7, 4),
      DateTime(2021, 7, 6),
      DateTime(2021, 8, 8),
      DateTime(2021, 8, 9),
    ];
  }

  // for list screen
  Future<List<FrameModel>> getLocationByDay(int index) async {
    /// each list inside list represent single collection of locations in fb
    return [
      // index 0. imitates location of first day
      [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 18),
              start: DateTime(2021, 7, 7, 17),
            ),
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 21),
              start: DateTime(2021, 7, 7, 20),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Львів',
            street: 'вул.Садова 11 Б',
            geoId: '1',
            location: LocationCoordinates(lat: 46.8763358, lng: 23.0022227),
          ),
        ),
      ],
      // 1
      [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 17),
              start: DateTime(2021, 7, 7, 16),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Львів',
            street: 'вул.Івана Сірка, 10',
            geoId: '2',
            location: LocationCoordinates(lat: 49.8763358, lng: 24.0022227),
          ),
        ),
      ],
      [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 18),
              start: DateTime(2021, 7, 7, 17),
            ),
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 21),
              start: DateTime(2021, 7, 7, 20),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Львів',
            street: 'вул.Стрийска, 48',
            geoId: '3',
            location: LocationCoordinates(lat: 48.8763358, lng: 23.0022227),
          ),
        ),
      ],
      [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 17),
              start: DateTime(2021, 7, 7, 16),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Львів',
            street: 'вул.Смол-Стоцького, 1',
            geoId: '4',
            location: LocationCoordinates(lat: 50.8763358, lng: 25.0022227),
          ),
        ),
      ]
    ].elementAt(index);
  }
}
