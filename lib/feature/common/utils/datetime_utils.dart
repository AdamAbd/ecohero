import 'package:intl/intl.dart';

class DateTimeUtils {
  String getDateTime(DateTime dateTime) {
    return DateFormat("MM/dd/yyyy HH:mm").format(dateTime);
  }
}
