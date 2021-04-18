import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateGroupSeparator extends StatelessWidget {
  final DateTime date;
  // ignore: sort_constructors_first
  DateGroupSeparator({required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: Center(
        child: Text(
          '${DateFormat.MMMMd().format(date)}',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}