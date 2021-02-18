import 'package:flutter/material.dart';

import 'global/loader_widget.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Идет инициализация данных...'), //TODO: internationalization
              SizedBox(
                height: 20.0,
              ),
              Loader(),
            ],
          ),
        ),
      ),
    );
  }
}
