import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../travel/weather_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final read = <int>{};
  static const notices = [
    ('✈️', '여행 D-5', '강릉 여행이 5일 남았어요.'),
    ('🌧️', '오늘 비 예보', '강수확률이 높아요. 비 오는 날 일정을 확인해보세요. (오늘 날씨 > 계획 2 확인)'),
    ('🤖', 'AI 취향 분석 완료', '바다·맛집·휴식을 좋아한다고 분석했어요.'),
    ('✏️', '일정 변경', '동행자가 일정을 수정했어요.'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('알림'), backgroundColor: Colors.white),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: List.generate(notices.length, (index) {
        final item = notices[index];
        final unread = !read.contains(index);
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          color: unread ? AppColors.soft : Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() => read.add(index));
              if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const WeatherScreen()),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.$1, style: const TextStyle(fontSize: 26)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.$3,
                          style: const TextStyle(
                            height: 1.4,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (unread)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}
