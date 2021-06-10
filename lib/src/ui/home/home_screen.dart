import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_useless_app/src/ui/google_maps_screen/google_maps_screen.dart';

import '../../core/provider/calendar_scroll_provider.dart';
import '../../core/provider/power_off_provider.dart';
import '../../core/provider/tab_listener.dart';
import '../power_off_list/date_list_screen.dart';
import '../power_off_list/water_list_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  final List<Widget> tabScreens = <Widget>[
    GoogleMapsScreen(),
    PowerOffListScreen(),
    Container(),

    // GoogleMapsScreenWater(),
    PowerOffWaterListScreen(), //List of something in future
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final powerOffProvider = Provider.of<PowerOffProvider>(
      context,
      listen: false,
    );

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      // if (powerOffProvider.city == -1) {
      //   //TODO: customize dialog widget
      //   await showDialog(
      //       context: context,
      //       builder: (BuildContext context) => AlertDialog(
      //             title: Text('which city'),
      //             content: Text('choose your city'),
      //             actions: [
      //               TextButton(
      //                   onPressed: () {
      //                     powerOffProvider.changeCity(chosenCity: 0);
      //                     Navigator.pop(context);
      //                   },
      //                   child: Text('Uzhgorod')),
      //               TextButton(
      //                   onPressed: () {
      //                     powerOffProvider.changeCity(chosenCity: 1);
      //                     Navigator.pop(context);
      //                   },
      //                   child: Text('Lvov')),
      //             ],
      //           ));
      // }
      // )
    });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CalendarScrollProvider>(
          create: (BuildContext context) => CalendarScrollProvider(
            dates: powerOffProvider.dates,
          ),
        ),
        ChangeNotifierProvider<TabListener>(
          create: (_) => TabListener(),
        ),
      ],
      child: Consumer<TabListener>(
        builder: (_, tabListener, __) {
          return ValueListenableBuilder(
            valueListenable: tabListener,
            builder: (BuildContext context, dynamic value, child) => Scaffold(
              body: SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    tabScreens.elementAt(value),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: CustomNavigationBar(
                          borderRadius: Radius.circular(24),
                          currentIndex: value,
                          isFloating: true,
                          scaleFactor: 0.4,
                          onTap: tabListener.tabIndex,
                          items: [
                            CustomNavigationBarItem(
                              icon: Icon(
                                Icons.bolt,
                                //   text: 'map'.tr(),
                              ),
                            ),
                            CustomNavigationBarItem(
                              icon: Icon(
                                Icons.list,

                                //text: 'list'.tr(),
                              ),
                            ),
                            CustomNavigationBarItem(
                              icon: Icon(
                                Icons.opacity,
                                //   text: 'map'.tr(),
                              ),
                            ),
                            CustomNavigationBarItem(
                              icon: Icon(
                                Icons.list,

                                //text: 'list'.tr(),
                              ),
                            ),
                            CustomNavigationBarItem(
                              icon: Icon(
                                Icons.person,
                                //    text: 'profile'.tr(),
                              ),
                            ),
                            CustomNavigationBarItem(
                              icon: Icon(
                                Icons.settings,
                                //text: 'settings'.tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
