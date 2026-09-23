import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/app_theme.dart';
import '../../widgets/itinerary_route_map.dart';
import '../travel/today_travel_screen.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  bool hardOpen = false;
  bool alternativesOpen = false;
  bool rebuilding = false;
  bool satellite = false;
  int selectedPlan = 0;
  int selectedDay = 0;

  static const _days = [
    ('DAY 1', '9월 24일'),
    ('DAY 2', '9월 25일'),
    ('DAY 3', '9월 26일'),
  ];

  static const plans = <List<_PlanStop>>[
    [
      _PlanStop(
        '10:30',
        '🚉',
        '강릉역',
        '기차역에서 안목해변으로',
        LatLng(37.7643, 128.8990),
      ),
      _PlanStop(
        '11:20',
        '🌊',
        '안목해변',
        '산책 · 사진 · 휴식',
        LatLng(37.7718, 128.9465),
      ),
      _PlanStop('12:10', '☕', '강릉 커피거리', '30분 휴식', LatLng(37.7704, 128.9440)),
      _PlanStop('13:30', '🍽️', '중앙시장', '점심 식사', LatLng(37.7554, 128.8962)),
      _PlanStop('16:30', '🏨', '숙소 체크인', '여유롭게 이동', LatLng(37.7529, 128.8902)),
    ],
    [
      _PlanStop(
        '10:40',
        '🚉',
        '강릉역',
        '택시로 실내 장소 이동',
        LatLng(37.7643, 128.8990),
      ),
      _PlanStop(
        '11:40',
        '☕',
        '안목해변 카페',
        '실내 관람 전 휴식',
        LatLng(37.7713, 128.9460),
      ),
      _PlanStop('13:00', '🏛️', '강릉시립미술관', '실내 관람', LatLng(37.7660, 128.9029)),
      _PlanStop('14:30', '🍽️', '중앙시장', '점심 식사', LatLng(37.7554, 128.8962)),
      _PlanStop('16:30', '🏨', '숙소 체크인', '여유롭게 이동', LatLng(37.7529, 128.8902)),
    ],
    [
      _PlanStop('10:30', '🚉', '강릉역', '경포호로 이동', LatLng(37.7643, 128.8990)),
      _PlanStop(
        '11:30',
        '🌳',
        '경포호 산책로',
        '완만한 산책 · 벤치',
        LatLng(37.7955, 128.8965),
      ),
      _PlanStop('12:40', '🍽️', '중앙시장', '점심 식사', LatLng(37.7554, 128.8962)),
      _PlanStop('14:10', '☕', '안목 카페거리', '실내 휴식', LatLng(37.7704, 128.9440)),
      _PlanStop('16:20', '🏨', '숙소 체크인', '여유롭게 이동', LatLng(37.7529, 128.8902)),
    ],
  ];

  Future<void> _rebuild() async {
    setState(() => rebuilding = true);
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    setState(() {
      rebuilding = false;
      selectedPlan = 1;
      hardOpen = false;
      alternativesOpen = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('더 편안한 일정으로 다시 만들었어요.')));
  }

  @override
  Widget build(BuildContext context) {
    final schedule = plans[selectedPlan];
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _mapHeader(schedule),
            _daySelector(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  _actionCard(),
                  if (alternativesOpen) _alternativePlans(),
                  const SizedBox(height: 18),
                  Text(
                    _days[selectedDay].$1,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '강릉 · ${_days[selectedDay].$2}',
                    style: const TextStyle(color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 10),
                  ...schedule.asMap().entries.map(
                    (entry) =>
                        _ScheduleItem(index: entry.key + 1, data: entry.value),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TodayTravelScreen(),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('오늘의 여행 보기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapHeader(List<_PlanStop> schedule) => Container(
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                tooltip: '이전',
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '강릉 여행 일정',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'DAY 1 · 9월 24일',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  children: [
                    _mapTypeButton(
                      '일반',
                      !satellite,
                      () => setState(() => satellite = false),
                    ),
                    _mapTypeButton(
                      '위성',
                      satellite,
                      () => setState(() => satellite = true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ItineraryRouteMap(
          points: schedule
              .map((item) => ItineraryMapPoint(item.place, item.position))
              .toList(),
          satellite: satellite,
          height: 208,
          label: '번호는 아래 일정 순서와 같아요.',
        ),
      ],
    ),
  );

  Widget _mapTypeButton(String label, bool selected, VoidCallback onTap) =>
      TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 36),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          foregroundColor: selected
              ? AppColors.primary
              : const Color(0xFF4B5563),
          backgroundColor: selected ? Colors.white : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      );

  Widget _daySelector() => Container(
    color: Colors.white,
    child: Row(
      children: [
        IconButton(
          onPressed: selectedDay == 0
              ? null
              : () => setState(() => selectedDay--),
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        ..._days.asMap().entries.map(
          (entry) => Expanded(
            child: TextButton(
              onPressed: () => setState(() => selectedDay = entry.key),
              style: TextButton.styleFrom(
                foregroundColor: selectedDay == entry.key
                    ? AppColors.primary
                    : const Color(0xFF6B7280),
                shape: const RoundedRectangleBorder(),
              ),
              child: Column(
                children: [
                  Text(
                    entry.value.$1,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(entry.value.$2, style: const TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: selectedDay == _days.length - 1
              ? null
              : () => setState(() => selectedDay++),
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    ),
  );

  Widget _actionCard() => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFE5E7EB)),
    ),
    child: Column(
      children: [
        ListTile(
          onTap: () => setState(() => hardOpen = !hardOpen),
          leading: const Icon(
            Icons.sentiment_dissatisfied_outlined,
            color: AppColors.primary,
          ),
          title: const Text(
            '일정이 힘들어요',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          trailing: Icon(hardOpen ? Icons.expand_less : Icons.expand_more),
        ),
        if (hardOpen)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '걷는 거리와 이동 횟수를 줄여 더 편한 일정으로 바꿔드릴게요.',
                  style: TextStyle(color: Color(0xFF4B5563)),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: rebuilding ? null : _rebuild,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: Text(
                    rebuilding ? 'AI가 일정을 다시 만들고 있어요...' : '일정 다시 만들기',
                  ),
                ),
              ],
            ),
          ),
        const Divider(height: 1),
        ListTile(
          onTap: () => setState(() {
            alternativesOpen = !alternativesOpen;
            hardOpen = false;
          }),
          leading: const Icon(
            Icons.compare_arrows_outlined,
            color: AppColors.primary,
          ),
          title: const Text(
            '다른 일정 보기',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          trailing: Icon(
            alternativesOpen ? Icons.expand_less : Icons.expand_more,
          ),
        ),
      ],
    ),
  );

  Widget _alternativePlans() => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      children: [1, 2]
          .map(
            (number) => Card(
              elevation: 0,
              child: ListTile(
                onTap: () => setState(() {
                  selectedPlan = number;
                  alternativesOpen = false;
                  hardOpen = false;
                }),
                leading: CircleAvatar(
                  backgroundColor: AppColors.soft,
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                title: Text(
                  '다른 일정 $number',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: Text(number == 1 ? '실내 관람과 휴식 중심' : '산책과 짧은 이동 중심'),
                trailing: const Text(
                  '선택하기',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({required this.index, required this.data});

  final int index;
  final _PlanStop data;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: const BorderSide(color: Color(0xFFEDEFF4)),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      leading: CircleAvatar(
        backgroundColor: index == 1
            ? const Color(0xFF16A34A)
            : AppColors.primary,
        child: Text(
          '$index',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        '${data.emoji}  ${data.place}',
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text('${data.time} · ${data.description}'),
      ),
    ),
  );
}

class _PlanStop {
  const _PlanStop(
    this.time,
    this.emoji,
    this.place,
    this.description,
    this.position,
  );

  final String time;
  final String emoji;
  final String place;
  final String description;
  final LatLng position;
}
