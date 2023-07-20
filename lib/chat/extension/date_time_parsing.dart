part of 'extensions.dart';

extension DateTimeParsing on DateTime {
  String chatDateTime() {
    if (day == DateTime.now().day &&
        month == DateTime.now().month &&
        year == DateTime.now().year) {
      return DateFormat.jm().format(this).toLowerCase();
      // return "same day";
    }

    return "${DateFormat('MMMM dd').format(this)}, ${DateFormat.jm().format(this).toLowerCase()}";
  }

  String howMayHourAgoTime() {
    if (day == DateTime.now().day &&
        month == DateTime.now().month &&
        year == DateTime.now().year &&
        hour <= DateTime.now().hour &&
        (DateTime.now().hour - hour) <= 8) {
      final int hourAgo = DateTime.now().hour - hour;
      if (hourAgo == 1 || hourAgo == 0) {
        return "$hourAgo Hour ago";
      } else {
        return "$hourAgo hours ago";
      }
    }

    return "${DateFormat('MMMM dd').format(this)}, ${DateFormat.jm().format(this)}";
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
