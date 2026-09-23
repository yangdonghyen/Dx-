import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/info_tile.dart';

class PastTripsScreen extends StatelessWidget {
  const PastTripsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('지난 여행'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                InfoTile('🏯', '전주 한옥마을 여행', '2026.08.12 ~ 08.14'),
                InfoTile('🌉', '부산 여행', '2026.06.02 ~ 06.04'),
                InfoTile('🌴', '제주 여행', '2026.04.10 ~ 04.13'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
