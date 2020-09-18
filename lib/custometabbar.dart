import 'package:flutter/material.dart';
import 'package:tabbar/tabbar.dart';

class CustomeTabBar extends StatefulWidget {
  CustomeTabBar({Key key}) : super(key: key);

  _CustomeTabBarState createState() => _CustomeTabBarState();
}

class _CustomeTabBarState extends State<CustomeTabBar> {
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo Home Page"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabbarHeader(
            controller: controller,
            tabs: [
              Tab(icon: Icon(Icons.map), text: "Map"),
              Tab(icon: Icon(Icons.list), text: "List"),
              Tab(icon: Icon(Icons.person), text: "User profile", ),
            ],
          ),
        ),
      ),
      body: TabbarContent(
        controller: controller,
        children: <Widget>[
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}