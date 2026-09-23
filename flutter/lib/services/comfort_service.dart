import '../models/trip.dart';

class ComfortService {
  static List<ScheduleItem> rebuild(List<ScheduleItem> items) => [
    for (final x in items) ...[
      x,
      if (x.emoji != '☕' && x.emoji != '🏨')
        const ScheduleItem('', '휴식 시간', '🛋', note: '20~30분 쉬어가기'),
    ],
  ];
}
