import 'package:easy_localization/easy_localization.dart';

class DateTimeRepository {
  static String dateToMonth(DateTime date) {
    return DateFormat.LLLL().format(date);
  }

  static String dateToMonthDay(DateTime date) {
    return DateFormat.MMMMd().format(date);
  }

  static String dateToHour(DateTime date) {
    return DateFormat.Hm().format(date);
  }
}
