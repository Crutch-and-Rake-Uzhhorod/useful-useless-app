import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/provider/calendar_scroll_provider.dart';
import '../../core/provider/power_off_provider.dart';
import 'widgets/calendar_scroll_web_widget.dart';
import 'widgets/date_list_web_widget.dart';
import 'widgets/sidebar_web_widget.dart';

class HomeScreenWeb extends StatelessWidget {
  //final LatLng _center = const LatLng(49.839634, 24.029115);
  static const String id = 'home_screen_web';

  @override
  Widget build(BuildContext context) {
    final powerOffProvider =
        Provider.of<PowerOffProvider>(context, listen: false);

    return ChangeNotifierProvider<CalendarScrollProvider>(
      create: (BuildContext context) => CalendarScrollProvider(
        dates: powerOffProvider.dates,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            Row(
              children: [
                Consumer2<CalendarScrollProvider, PowerOffProvider>(
                  builder: (_, calendarScrollProvider, powerOffProvider, __) {
                    return Expanded(
                      flex: 5,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: powerOffProvider.chosenLatLng(),
                          zoom: 13.0,
                        ),
                        markers: powerOffProvider.markers!.elementAt(
                          calendarScrollProvider.currentIndex!,
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Flexible(child: CalendarScrollWebWidget()),
                        Expanded(flex: 3, child: DateListWebWidget()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SidebarWidget(isHome: true, child: Container()),
          ],
        ),
      ),
    );
  }
}
