import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../discovery/place_detail_screen.dart';

/// 직접 입력 검색과 원본 웹의 지역 행사·축제 태그를 제공한다.
class TextSearchScreen extends StatefulWidget {
  const TextSearchScreen({super.key});
  @override
  State<TextSearchScreen> createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends State<TextSearchScreen> {
  final controller = TextEditingController();
  String query = '';
  static const places = [
    ('안목해변', '강원 강릉시', '🌊', '강릉커피축제', '축제 진행 중'),
    ('황리단길', '경북 경주시', '🏯', '신라문화제', '축제 진행 중'),
    ('애월 해안도로', '제주 제주시', '🚗', '제주들불축제', '축제 진행 중'),
    ('광안리해수욕장', '부산 수영구', '🌃', '부산불꽃축제', '행사 진행 중'),
    ('전주 한옥마을', '전북 전주시', '🏘️', '전주비빔밥축제', '축제 진행 중'),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final normalized = query.trim();
    final filtered = normalized.isEmpty
        ? const <(String, String, String, String, String)>[]
        : places
              .where(
                (place) =>
                    place.$1.contains(normalized) ||
                    place.$2.contains(normalized),
              )
              .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('여행지 검색'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller,
            onChanged: (value) => setState(() => query = value),
            onSubmitted: (value) => setState(() => query = value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: '예: 강릉, 제주, 안목해변',
              suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                  setState(() => query = '');
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (normalized.isEmpty)
            const Text(
              '가고 싶은 여행지 이름이나 지역을 입력해주세요.',
              style: TextStyle(color: Color(0xFF6B7280)),
            )
          else ...[
            Text(
              '검색 결과 ${filtered.length}곳',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            if (filtered.isEmpty)
              const Text('일치하는 여행지가 없어요. 다른 지역이나 짧은 검색어로 찾아보세요.')
            else
              ...filtered.map((place) => _PlaceResult(place: place)),
          ],
        ],
      ),
    );
  }
}

class _PlaceResult extends StatelessWidget {
  const _PlaceResult({required this.place});
  final (String, String, String, String, String) place;
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
    child: InkWell(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const PlaceDetailScreen())),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${place.$3}  ${place.$1}',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(place.$2, style: const TextStyle(color: Color(0xFF6B7280))),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3D6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '🎉 ${place.$5} · ${place.$4}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8A5200),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 11),
            const Text(
              '장소 자세히 보기 →',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
