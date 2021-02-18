import 'package:easy_localization/easy_localization.dart';

class DateTimeRepository{
  final DateFormat _monthFormatter = DateFormat('LLLL');

  String dateToMonth(DateTime date){
    return _monthFormatter.format(date);
  }
}