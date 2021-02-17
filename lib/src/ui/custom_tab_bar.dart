import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'global/google_maps_widget.dart';
import 'profile_screen.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  List widgetOptions = [
    //TODO: fix TabBar body
    GoogleMapsWidget(),
    Container(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    //TODO: no set_state allowed, only Provider.of<T>(context)
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr()),
        centerTitle: true,
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
