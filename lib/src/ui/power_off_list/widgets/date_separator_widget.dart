import 'package:flutter/material.dart';

import '../../../core/repository/date_time_repository.dart';

class DateSeparatorWidget extends StatelessWidget {
  DateSeparatorWidget({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        color: Colors.black12,
        child: Text(
          DateTimeRepository.dateToMonthDay(date),
          style: textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
