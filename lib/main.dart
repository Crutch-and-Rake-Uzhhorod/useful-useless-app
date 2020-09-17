import 'package:flutter/material.dart';
import 'package:useful_useless_app/common/google_maps_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('7.Adding Map'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMapsWidget()
      )
    );
  }
}