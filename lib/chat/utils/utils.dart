import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static DateTime? toDateTime(Timestamp? value) {
    return value?.toDate();
  }

  static DateTime fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }
}
