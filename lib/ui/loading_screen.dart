import 'package:flutter/material.dart';
import 'package:useful_useless_app/ui/global/loader_widget.dart';


class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Идет инициализация данных...'),
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

