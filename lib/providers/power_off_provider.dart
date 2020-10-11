import 'package:flutter/foundation.dart';
import 'package:useful_useless_app/models/frame_model.dart';
import 'package:useful_useless_app/models/location_model.dart';

class PowerOffProvider with ChangeNotifier {

  List<FrameModel> _framedLocations;

  // Date selected on Date picker
  DateTime _date;

  List<FrameModel> get framedLocations {

    if(_framedLocations == null){
      _framedLocations = [];

      var location1 = LocationModel(
        city: 'Uzhhorod',
        street: 'Капітульна',
        building_number: '33',
        location: {
          'lat': '48.621679',
          'lon': '22.306654',
        },
        locationID: "location1",
        type: 0,
        users: [],
      );

      _framedLocations.add(FrameModel(
        frames: [
          {
            'start' : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 12)),
            'end' :  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 15)),
          },
          {
            'start' : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 18)),
            'end' :  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 20)),
          }
          ],
        haus_detaile: location1
      ));


      var location2 = LocationModel(
        city: 'Uzhhorod',
        street: 'Капітульна',
        building_number: '33',
        location: {
          'lat': '48.621679',
          'lon': '22.306654',
        },
        locationID: "location2",
        type: 0,
        users: [],
      );
      _framedLocations.add(FrameModel(
          frames: [
            {
              'start' : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( days: 1, hours: 12)),
              'end' :  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( days: 1, hours: 15)),
            }
          ],
          haus_detaile: location1
      ));

      var location3 = LocationModel(
        city: 'Uzhhorod',
        street: 'Минайська',
        building_number: '16',
        location: {
          'lat': '48.608976',
          'lon': '22.289751',
        },
        locationID: "location3",
        type: 0,
        users: [],
      );
      _framedLocations.add(FrameModel(
          frames: [
            {
              'start' : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 8)),
              'end' :  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 9)),
            },
            {
              'start' : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 15)),
              'end' :  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration( hours: 18)),
            }
          ],
          haus_detaile: location1
      ));
    }
    return [..._framedLocations];
  }

  DateTime get date {
    return _date;
  }

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }
}

