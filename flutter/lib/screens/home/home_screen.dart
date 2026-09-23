import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../discovery/map_screen.dart';
import '../my/profile_screen.dart';
import '../preference/youtube_saved_screen.dart';
import '../search/text_search_screen.dart';
import '../search/voice_search_screen.dart';
import '../travel/today_travel_screen.dart';
import '../travel/weather_screen.dart';
import '../trip/itinerary_screen.dart';
import '../trip/trip_places_screen.dart';

/// React 홈 화면과 같은 큰 터치 영역의 시니어 친화 홈이다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.seniorMode = true});
  final bool seniorMode;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  void _push(Widget screen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _homeBody(),
      const MapScreen(),
      const YoutubeSavedScreen(),
      ProfileScreen(senior: widget.seniorMode),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (value) => setState(() => _tab = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: '탐색',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: '저장',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '마이',
          ),
        ],
      ),
    );
  }

  Widget _homeBody() {
    final menus = <_HomeMenu>[
      _HomeMenu(
        Icons.calendar_month_outlined,
        '전체 일정',
        () => _push(const ItineraryScreen()),
      ),
      _HomeMenu(
        Icons.today_outlined,
        '오늘의 일정',
        () => _push(const TodayTravelScreen()),
      ),
      _HomeMenu(
        Icons.add_location_alt_outlined,
        '여행 만들기',
        () => _push(const TripPlacesScreen()),
      ),
      _HomeMenu(
        Icons.cloud_outlined,
        '오늘 날씨',
        () => _push(const WeatherScreen()),
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF3F7FF), Color(0xFFF9F5FF), Color(0xFFF2FBF8)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '여행메이트',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '안녕하세요, 민우님',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '어디로 떠나볼까요?',
                      style: TextStyle(fontSize: 16, color: Color(0xFF4B5563)),
                    ),
                  ],
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                  tooltip: '알림',
                ),
              ],
            ),
            const SizedBox(height: 20),
            _section(
              title: '어디로 여행 갈까요?',
              child: Row(
                children: [
                  Expanded(
                    child: _SearchTile(
                      icon: Icons.search,
                      label: '직접 입력',
                      color: AppColors.soft,
                      onTap: () => _push(const TextSearchScreen()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SearchTile(
                      icon: Icons.mic_none_rounded,
                      label: '말로 찾기',
                      color: AppColors.primary,
                      foreground: Colors.white,
                      onTap: () => _push(const VoiceSearchScreen()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '무엇을 도와드릴까요?',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: menus.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.22,
                ),
                itemBuilder: (context, index) {
                  final menu = menus[index];
                  return InkWell(
                    onTap: menu.onTap,
                    borderRadius: BorderRadius.circular(24),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: const BoxDecoration(
                              color: AppColors.soft,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              menu.icon,
                              size: 31,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            menu.label,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({required String title, required Widget child}) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 8)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        child,
      ],
    ),
  );
}

class _SearchTile extends StatelessWidget {
  const _SearchTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.foreground = AppColors.primary,
  });
  final IconData icon;
  final String label;
  final Color color;
  final Color foreground;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: color,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 94,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foreground, size: 32),
            const SizedBox(height: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _HomeMenu {
  const _HomeMenu(this.icon, this.label, this.onTap);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
