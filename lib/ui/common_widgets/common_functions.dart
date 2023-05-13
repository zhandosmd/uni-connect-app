import 'package:intl/intl.dart';

abstract class CommonFunctions{

  static String formatDateTimeToString(DateTime date){
    return DateFormat('d MMMM, y').format(date);
  }
}