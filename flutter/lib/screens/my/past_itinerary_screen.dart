import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/info_tile.dart';

class PastItineraryScreen extends StatelessWidget {
  const PastItineraryScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('지난 여행 일정'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                Text(
                  'DAY 1',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                InfoTile('🏯', '전주 한옥마을', '전통문화 체험'),
                InfoTile('🍲', '전주비빔밥', '점심 식사'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
