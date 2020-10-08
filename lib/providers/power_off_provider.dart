import 'package:flutter/foundation.dart';
import 'package:useful_useless_app/models/house.dart';

class PowerOffProvider with ChangeNotifier {

  final List<House> _locations = [
    House(
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

  List<House> get locations {
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

