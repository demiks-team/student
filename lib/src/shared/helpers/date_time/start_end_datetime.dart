import 'package:intl/intl.dart';

String convertDateToLocal(String dateTime) {
  return DateFormat("yyyy-MM-dd").format(DateTime.parse(dateTime).toLocal());
}

String convertStartEndDateHours(String startDate, String endDate) {
  var convertedStartDate =
      DateFormat("jm").format(DateTime.parse(startDate).toLocal());
  var convertedEndDate =
      DateFormat("jm").format(DateTime.parse(endDate).toLocal());

  return convertedStartDate + " to " + convertedEndDate;
}
