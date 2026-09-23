import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/app_theme.dart';
import '../../widgets/itinerary_route_map.dart';
import 'rest_search_screen.dart';

class TodayTravelScreen extends StatelessWidget {
  const TodayTravelScreen({super.key});

  static const schedule = <_Schedule>[
    _Schedule(
      '09:30',
      '☕',
      '안목해변 카페',
      '도보 5분',
      '카페 · 그늘 · 화장실',
      LatLng(37.7718, 128.9465),
    ),
    _Schedule(
      '11:20',
      '🏛️',
      '강릉시립미술관',
      '택시 12분',
      '실내 관람 · 휴식',
      LatLng(37.7660, 128.9029),
    ),
    _Schedule(
      '13:00',
      '🍽️',
      '강릉 중앙시장',
      '도보 8분',
      '식사 · 실내',
      LatLng(37.7554, 128.8962),
    ),
    _Schedule(
      '15:00',
      '🌊',
      '경포호 산책로',
      '택시 8분',
      '산책 · 벤치',
      LatLng(37.7955, 128.8965),
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        tooltip: '이전',
      ),
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('오늘의 여행', style: TextStyle(fontWeight: FontWeight.w900)),
          SizedBox(height: 2),
          Text(
            'DAY 2 · 9월 25일',
            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    ),
    body: Column(
      children: [
        ItineraryRouteMap(
          points: schedule
              .map((item) => ItineraryMapPoint(item.place, item.position))
              .toList(),
          satellite: false,
          height: 192,
          label: '오늘의 이동 경로',
          onMarkerTap: (index) => _showDetail(context, schedule[index]),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 13),
          color: AppColors.soft,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '현재 일정',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              SizedBox(height: 3),
              Text(
                '☕ 안목해변 카페',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 2),
              Text(
                '09:30',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
            children: [
              const Text(
                '오늘의 일정',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              ...schedule.asMap().entries.map(
                (entry) => _ScheduleCard(
                  number: entry.key + 1,
                  item: entry.value,
                  onTap: () => _showDetail(context, entry.value),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  static void _showDetail(BuildContext context, _Schedule item) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 6, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${item.emoji}  ${item.place}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '${item.time} 일정',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _detailBox('이동', item.travel),
                  const SizedBox(width: 10),
                  _detailBox('일정 특징', item.tags),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => Navigator.of(sheetContext).push(
                  MaterialPageRoute(
                    builder: (_) => RestSearchScreen(targetPlace: item.place),
                  ),
                ),
                icon: const Icon(Icons.chair_outlined),
                label: Text('${item.place} 주변 휴식 장소 찾기'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  backgroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _detailBox(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    ),
  );
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.number,
    required this.item,
    required this.onTap,
  });

  final int number;
  final _Schedule item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    elevation: 0,
    color: number == 1 ? const Color(0xFFF0FBF2) : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: BorderSide(
        color: number == 1 ? const Color(0xFF86D19C) : const Color(0xFFEDEFF4),
      ),
    ),
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: number == 1
            ? const Color(0xFF16A34A)
            : AppColors.primary,
        child: Text(
          '$number',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      title: Text(
        '${item.emoji}  ${item.place}',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          '${item.time} · ${item.travel}',
          style: const TextStyle(fontSize: 14),
        ),
      ),
      trailing: const Text(
        '상세',
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class _Schedule {
  const _Schedule(
    this.time,
    this.emoji,
    this.place,
    this.travel,
    this.tags,
    this.position,
  );

  final String time;
  final String emoji;
  final String place;
  final String travel;
  final String tags;
  final LatLng position;
}
