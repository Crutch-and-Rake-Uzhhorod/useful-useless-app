import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/calendar_scroll_provider.dart';
import '../../core/provider/power_off_provider.dart';
import '../../core/provider/tab_listener.dart';
import '../map_tab/google_maps_screen.dart';
import '../profile/profile_screen.dart';

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
    final powerOffProvider = Provider.of<PowerOffProvider>(context);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (powerOffProvider.city == -1) {
        //TODO: customize dialog widget
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('which city'),
                  content: Text('choose your city'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          powerOffProvider.changeCity(chosenCity: 0);
                          Navigator.pop(context);
                        },
                        child: Text('Uzhgorod')),
                    TextButton(
                        onPressed: () {
                          powerOffProvider.changeCity(chosenCity: 1);
                          Navigator.pop(context);
                        },
                        child: Text('Lvov')),
                  ],
                ));
      }
      // )
    });
    return ChangeNotifierProvider<CalendarScrollProvider>(
      create: (BuildContext context) => CalendarScrollProvider(
        dates: powerOffProvider.dates,
      ),
      child: ValueListenableBuilder(
        valueListenable: tabListener.indexedTab,
        builder: (BuildContext context, dynamic value, child) => Scaffold(
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
