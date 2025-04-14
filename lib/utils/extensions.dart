import 'package:intl/intl.dart';

extension DateTimeFormatExtension on DateTime {
  String get getReadableFormat {
    return DateFormat('MMMM d, y').format(this);
  }
}