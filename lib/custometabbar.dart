import 'package:flutter/material.dart';
import 'package:tabbar/tabbar.dart';
import 'common/google_maps_widget.dart';
import 'localization/language_view.dart';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'localization/local_keys.dart';

class CustomeTabBar extends StatefulWidget {
  @override
  _CustomeTabBarState createState() => _CustomeTabBarState();
}

class _CustomeTabBarState extends State<CustomeTabBar> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    log(context.locale.toString(),
        name: '${this} # locale Context');
    log('title'.tr().toString(), name: '${this} # locale');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
        centerTitle: true,
        actions: <Widget>[
            FlatButton(
              child: Icon(Icons.language, color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => LanguageView(), fullscreenDialog: true),
                );
              },
            ),
          ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabbarHeader(
            controller: controller,
            tabs: [
              Tab(icon: Icon(Icons.map),
                  text: (LocaleKeys.map).tr()),
              Tab(icon: Icon(Icons.list),
                  text: (LocaleKeys.list).tr()),
              Tab(
                icon: Icon(Icons.person),
                text: (LocaleKeys.profile).tr(),
              ),
            ],
          ),
        ),
      ),
      body: TabbarContent(
        controller: controller,
        children: <Widget>[
          GoogleMapsWidget(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
