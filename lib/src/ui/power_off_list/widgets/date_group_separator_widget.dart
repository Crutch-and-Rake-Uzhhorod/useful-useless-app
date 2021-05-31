import 'package:flutter/material.dart';

import '../../../core/repository/date_time_repository.dart';

class DateGroupSeparatorWidget extends StatelessWidget {
  DateGroupSeparatorWidget({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 60.0,
      child: Center(
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
