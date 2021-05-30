import 'package:flutter/material.dart';

import '../../../core/repository/date_time_repository.dart';

class DateGroupSeparatorWebWidget extends StatelessWidget {
  DateGroupSeparatorWebWidget({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
        color: Colors.white,
      ),
      height: 60.0,
      alignment: Alignment.center,
      child: Text(
        DateTimeRepository.dateToMonthDay(date),
        style: textTheme.headline6?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: const Color(0xff2F4047),
        ),
      ),
    );
  }
}
