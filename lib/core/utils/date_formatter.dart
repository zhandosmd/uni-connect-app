import 'package:intl/intl.dart';

String dateFormat(DateTime dateTime) {
  return DateFormat('dd.MM.yyyy, hh:mm').format(dateTime);
}
