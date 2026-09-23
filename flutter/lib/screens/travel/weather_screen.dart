import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'today_travel_screen.dart';

/// 원본 웹의 날씨별 계획 1·2·3 전환을 Flutter로 이식한다.
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int plan = 1;
  static const plans = [
    ('🌤️', '계획 1 · 기본 일정', '안목해변 산책 → 커피거리 → 중앙시장'),
    ('🌧️', '계획 2 · 비 오는 날 일정', '오죽헌 → 강릉시립미술관 → 실내 카페'),
    ('☀️', '계획 3 · 더운 날 일정', '이른 해변 산책 → 박물관 → 그늘 카페'),
  ];

  @override
  Widget build(BuildContext context) {
    final selected = plans[plan - 1];
    return Scaffold(
      appBar: AppBar(title: const Text('오늘 날씨'), backgroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF173B76),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '강릉 · 현재 날씨',
                  style: TextStyle(
                    color: Color(0xFFBFDBFE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('🌧️', style: TextStyle(fontSize: 48)),
                    SizedBox(width: 12),
                    Text(
                      '19°',
                      style: TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '비',
                      style: TextStyle(fontSize: 18, color: Color(0xFFDBEAFE)),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(child: _Metric('강수확률', '70%')),
                    SizedBox(width: 8),
                    Expanded(child: _Metric('습도', '86%')),
                    SizedBox(width: 8),
                    Expanded(child: _Metric('바람', '3.4m/s')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            '날씨별 오늘 일정',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          const Text('현재 비 예보에는 계획 2를 추천해요.'),
          const SizedBox(height: 14),
          Row(
            children: List.generate(3, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index == 2 ? 0 : 8),
                  child: ChoiceChip(
                    label: Text('계획 ${index + 1}'),
                    selected: plan == index + 1,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: plan == index + 1
                          ? Colors.white
                          : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (_) => setState(() => plan = index + 1),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.soft,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${selected.$1}  ${selected.$2}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 9),
                Text(selected.$3, style: const TextStyle(height: 1.5)),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TodayTravelScreen(),
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('이 일정으로 여행 보기'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFFBFDBFE)),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
