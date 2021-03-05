import 'dart:collection';

import 'package:flutter/foundation.dart';
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
    _markers = await _mockRepository.getMarkers();
    _dates = await _mockRepository.getDates();
  }
}
