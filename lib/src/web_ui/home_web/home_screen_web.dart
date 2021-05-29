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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final scrollSize = MediaQuery.of(context).size.height - 150;

    final powerOffProvider =
        Provider.of<PowerOffProvider>(context, listen: false);

    return ChangeNotifierProvider<CalendarScrollProvider>(
      create: (BuildContext context) => CalendarScrollProvider(
        dates: powerOffProvider.dates,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        endDrawer: Drawer(
          child: Center(child: DateListWebWidget()),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => Scaffold.of(context).openEndDrawer(),
        //   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //   child: Icon(Icons.list),
        // ),
        body: Stack(
          children: <Widget>[
            Row(
              children: [
                Consumer<CalendarScrollProvider>(
                  builder:
                      (_, CalendarScrollProvider calendarScrollProvider, __) {
                    return Expanded(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: powerOffProvider.chosenLatLng(),
                          zoom: 13.0,
                        ),
                        markers: powerOffProvider.markers![0],
                      ),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.only(bottom: 24),
                  width: 100,
                  //height: MediaQuery.of(context).size.height - 150,
                  alignment: Alignment.center,
                  child: CalendarScrollWebWidget(scrollSize: scrollSize),
                ),
              ],
            ),
            Align(
              alignment: Alignment(0.85, -0.95),
              child: FloatingActionButton(
                onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                child: Icon(Icons.list),
              ),
            ),
            SidebarWidget(isHome: true, child: Container()),
          ],
        ),
      ),
    );
  }
}
