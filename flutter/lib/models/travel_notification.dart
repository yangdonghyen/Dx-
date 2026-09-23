class TravelNotification {
  const TravelNotification(
    this.emoji,
    this.title,
    this.body,
    this.time, {
    this.unread = false,
  });
  final String emoji, title, body, time;
  final bool unread;
}
