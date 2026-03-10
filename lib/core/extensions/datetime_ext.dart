extension DateTimeExt on DateTime {
  String toDisplayDate() {
    return '$year/${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}';
  }

  String toDisplayTime() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
