extension DurationExt on Duration {
  String toHHMM() {
    final h = inHours;
    final m = inMinutes.remainder(60).toString().padLeft(2, '0');
    return '${h}h ${m}m';
  }

  String toHHMMSS() {
    final h = inHours.toString().padLeft(2, '0');
    final m = inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}
