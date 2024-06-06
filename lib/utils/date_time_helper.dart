import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateTimeHelper {
  static String FORMAT_TIME_ZONE = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

  static String formatDate(DateTime dateTime, {String format = "yMMMd"}) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(dateTime);
  }

  static DateTime parseDate(String dateTime) {
    DateFormat dateFormat = DateFormat("yMMMd");
    return dateFormat.parse(dateTime);
  }

  static String getHourAndMinusFromDate(String datetime) {
    if (datetime.isEmpty) return '';
    var dateFormat = DateFormat('HH:mm a');
    return dateFormat.format(DateTime.parse(datetime));
  }

  static String getDateLocal(String datetime) {
    var dateFormat = DateFormat('dd-MMM-yyyy hh:mm:ss a');
    return dateFormat.format(DateTime.parse(datetime).toLocal());
  }

  static String getUtcToLocalTime(DateTime datetime,
      {String format = 'EEE, MMM. d, yyyy'}) {
    var dateFormat = DateFormat(format);
    var utcDate = dateFormat.format(datetime);
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    return dateFormat.format(DateTime.parse(localDate));
  }

  static DateTime updateTimeZone(String datetime) {
    final DateTime createAt =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(datetime);
    var dateNew = createAt.add(createAt.timeZoneOffset);
    return dateNew;
  }

  static DateTime getUtcToLocalTimeByDateTime(String datetime,
      {String format = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}) {
    var dateFormat = DateFormat(format);
    var utcDate = dateFormat.format(DateTime.parse(datetime));
    return dateFormat.parse(utcDate, true).toLocal();
  }

  static String getTimeZoneRegion() {
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;
    return locations.keys.first;
  }

  static String timeToDecimal(String timeString) {
    List<String> timeParts = timeString.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    double decimalTime = hours + (minutes / 60);
    String formattedTime = decimalTime.toStringAsFixed(1);

    if (formattedTime.endsWith('.0')) {
      return formattedTime.split('.')[0];
    } else {
      return formattedTime;
    }
  }
}
