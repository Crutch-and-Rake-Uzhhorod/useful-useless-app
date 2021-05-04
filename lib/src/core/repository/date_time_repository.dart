import 'package:easy_localization/easy_localization.dart';

class DateTimeRepository {
  static String dateToMonth(DateTime date) {
    return DateFormat.LLLL().format(date);
  }

  static String dateToMonthDay(DateTime dateTime) {
    return DateFormat.MMMMd().format(dateTime);
  }
}
