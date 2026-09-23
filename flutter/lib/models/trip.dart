import 'place.dart';
import 'companion.dart';

class ScheduleItem {
  const ScheduleItem(this.time, this.title, this.emoji, {this.note = ''});
  final String time, title, emoji, note;
}

class DayPlan {
  const DayPlan(this.day, this.date, this.items);
  final int day;
  final DateTime date;
  final List<ScheduleItem> items;
}

class TripDraft {
  DateTime start = DateTime(2026, 9, 24), end = DateTime(2026, 9, 28);
  int travelers = 2;
  List<String> transport = ['기차'];
  String budget = '30~50만원';
  List<Place> places = [];
  List<Companion> companions = [];
}
