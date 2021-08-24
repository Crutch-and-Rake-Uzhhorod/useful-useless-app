import 'package:flutter/material.dart';

import '../../../core/repository/date_time_repository.dart';

class DateSeparatorWidget extends StatelessWidget {
  DateSeparatorWidget({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2.0),
        gradient: LinearGradient(
          colors: [
            Colors.grey[400]!,
            Colors.white,
            Colors.grey[400]!,
          ],
          stops: [0.0, 0.5, 1.0]
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(10, 12),
            blurRadius: 10,
            spreadRadius: 0.1,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        height: 50.0,
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
