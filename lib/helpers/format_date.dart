import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat("yyyy-MM-dd: HH:MM")
      .format(DateTime.parse(date.toString()));
}
