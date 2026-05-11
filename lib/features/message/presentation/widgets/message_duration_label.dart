class MessageDurationLabel {
  const MessageDurationLabel._();

  static String format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString();
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours;
    if (hours > 0) {
      final safeMinutes = minutes.padLeft(2, '0');
      return '$hours:$safeMinutes:$seconds';
    }

    return '$minutes:$seconds';
  }
}
