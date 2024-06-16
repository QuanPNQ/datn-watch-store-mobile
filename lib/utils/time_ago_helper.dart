import 'package:timeago/timeago.dart' as timeago;

class TimeAgoHelper extends timeago.ViMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String lessThanOneMinute(int seconds) => 'Vừa xong';

  @override
  String aboutAMinute(int minutes) => '1 phút';

  @override
  String minutes(int minutes) => '$minutes phút';

  @override
  String aboutAnHour(int minutes) => '1 giờ';

  @override
  String hours(int hours) => '$hours giờ';

  @override
  String aDay(int hours) => '1 ngày';

  @override
  String days(int days) => '$days ngày';

  @override
  String aboutAMonth(int days) => '1 tháng';

  @override
  String months(int months) => '$months tháng';

  @override
  String aboutAYear(int year) => '1 năm';

  @override
  String years(int years) => '$years năm';
}
