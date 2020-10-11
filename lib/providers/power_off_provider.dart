import 'package:flutter/foundation.dart';
import 'package:useful_useless_app/models/location_model.dart';

class PowerOffProvider with ChangeNotifier {

  final List<LocationModel> _locations = [
    LocationModel(
        street: 'Швабска',
        building_number: '51',
        city: 'Uzhhorod',
        location: {
          'lang' : '0.0',
          'lat' : '0.0'
        },
        users: []
    ),
  ];

  DateTime _date;

  List<LocationModel> get locations {
    return [..._locations];
  }

  DateTime get date {
    return _date;
  }

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }
}

