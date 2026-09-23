import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../preference/ai_analysis_screen.dart';
import '../preference/youtube_saved_screen.dart';
import '../travel/today_travel_screen.dart';
import 'past_trips_screen.dart';

/// 웹 앱의 최신 마이페이지 구조를 반영한 Flutter 화면이다.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.senior = true});
  final bool senior;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool senior = widget.senior;
  void _push(Widget screen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF3F7FF), Color(0xFFF9F5FF), Color(0xFFF2FBF8)],
      ),
    ),
    child: ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      children: [
        const Text(
          '여행메이트',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          '마이페이지',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 16),
        _profileSummary(),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.25,
                children: [
                  _menu(
                    Icons.calendar_month_outlined,
                    '내 여행 일정',
                    const Color(0xFF4169D8),
                    () => _push(const TodayTravelScreen()),
                  ),
                  _menu(
                    Icons.flight_takeoff_outlined,
                    '지난 여행',
                    const Color(0xFF8B5E3C),
                    () => _push(const PastTripsScreen()),
                  ),
                  _menu(
                    Icons.bookmark_outline,
                    '저장한 장소',
                    const Color(0xFFD14D72),
                    () => _push(const YoutubeSavedScreen()),
                  ),
                  _seniorMenu(),
                ],
              ),
              const SizedBox(height: 14),
              _aiCard(),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _profileSummary() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                '민',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Text(
              '민우님',
              style: TextStyle(
                fontSize: senior ? 22 : 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Row(
          children: [
            Expanded(child: _Stat('지난 여행', '3회')),
            SizedBox(height: 38, child: VerticalDivider()),
            Expanded(child: _Stat('저장 장소', '6곳')),
          ],
        ),
      ],
    ),
  );

  Widget _menu(IconData icon, String label, Color color, VoidCallback tap) =>
      Material(
        color: const Color(0xFFF9FAFF),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: tap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: Colors.white, size: 23),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: senior ? 16 : 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _seniorMenu() => Material(
    color: senior ? AppColors.soft : const Color(0xFFF9FAFF),
    borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onTap: () => setState(() => senior = !senior),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF0F766E),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.text_fields_rounded,
                color: Colors.white,
                size: 23,
              ),
            ),
            Text(
              '시니어 모드',
              style: TextStyle(
                fontSize: senior ? 16 : 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _aiCard() => Material(
    color: const Color(0xFFF4F1FF),
    borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onTap: () => _push(const AiAnalysisScreen()),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.purple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.smart_toy_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                'AI 취향 재분석',
                style: TextStyle(
                  fontSize: senior ? 18 : 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.purple),
          ],
        ),
      ),
    ),
  );
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
      ),
    ],
  );
}
