import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/info_tile.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('장소 상세'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                Center(child: Text('🌊', style: TextStyle(fontSize: 100))),
                Text(
                  '안목해변',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                Text('강원 강릉시 창해로'),
                InfoTile('☕', '주변 카페', '도보 3분'),
                InfoTile('🍲', '주변 맛집', '차량 8분'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
