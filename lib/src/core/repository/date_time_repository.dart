import 'package:easy_localization/easy_localization.dart';

class DateTimeRepository {
  static String dateToMonth(DateTime date) {
    return DateFormat.LLLL().format(date);
  }

  static String dateToMonthDay(DateTime date) {
    final raw = DateFormat.MMMMd().format(date);
    final words = raw.split(' ');
    return '${words.first.tr()} ${words.last}';
  }

  static String dateToHour(DateTime date) {
    return DateFormat.Hm().format(date);
  }
}
