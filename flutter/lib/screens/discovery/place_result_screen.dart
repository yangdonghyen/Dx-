import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/info_tile.dart';

class PlaceResultScreen extends StatelessWidget {
  const PlaceResultScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('장소 찾기 결과'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                Center(child: Text('🌊', style: TextStyle(fontSize: 100))),
                Text(
                  '안목해변',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                Text('강원 강릉시 · AI 신뢰도 높음'),
                SizedBox(height: 12),
                InfoTile('☕', '안목 카페거리', '도보 3분'),
                InfoTile('🍲', '강릉 중앙시장', '차량 12분'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
