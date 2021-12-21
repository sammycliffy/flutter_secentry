import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(DateTime.parse(date.toString()));
}
