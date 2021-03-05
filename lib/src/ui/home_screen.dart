import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_useless_app/src/core/provider/tab_listener.dart';

import '../core/provider/calendar_scroll_provider.dart';
import '../core/provider/power_off_provider.dart';
import 'map_tab/google_maps_widget.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  final TabListener tabListener = TabListener();

  final List<Widget> tabScreens = <Widget>[
    GoogleMapsScreen(),
    Container(), //List of something in future
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CalendarScrollProvider>(
          create: (BuildContext context) => CalendarScrollProvider(
            dates: Provider.of<PowerOffProvider>(context, listen: false).dates,
          ),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: tabListener.indexedTab,
        builder: (BuildContext context, value, child) => Scaffold(
          body: SafeArea(child: tabScreens.elementAt(value)),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value,
            selectedItemColor: Colors.blueAccent,
            onTap: tabListener.tabIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                  size: 40.0,
                ),
                label: 'map'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 40.0,
                ),
                label: 'list'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 40.0,
                ),
                label: 'profile'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
