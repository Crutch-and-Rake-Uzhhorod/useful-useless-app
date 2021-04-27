import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateGroupSeparatorWidget extends StatelessWidget {

  DateGroupSeparatorWidget({required this.date});
  final DateTime? date;

  String _dateFormatter({DateTime? dateTime}) {
    return DateFormat.MMMMd().format(dateTime!).toString();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 60.0,
      child: Center(
        child: Text(
          '${_dateFormatter(dateTime: date)}',
          style: textTheme.headline6?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
