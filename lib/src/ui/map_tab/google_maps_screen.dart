import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/provider/calendar_scroll_provider.dart';
import '../../core/provider/power_off_provider.dart';
import '../global/calendar_scroll_widget.dart';

class GoogleMapsScreen extends StatelessWidget {
  //final LatLng _center = const LatLng(49.839634, 24.029115);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CalendarScrollWidget(),
        Expanded(
          child: Consumer2<CalendarScrollProvider, PowerOffProvider>(
            builder: (_, calendarScrollProvider, powerOffProvider, __) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: powerOffProvider.chosenLatLng(),
                  zoom: 13.0,
                ),
                markers: powerOffProvider.markers!.elementAt(
                  calendarScrollProvider.currentIndex!,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
