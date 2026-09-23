import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';

class TasteConfirmScreen extends StatelessWidget {
  const TasteConfirmScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('취향 확인'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                Text(
                  '이런 여행을 좋아하시네요',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text('🌊 바다')),
                    Chip(label: Text('☕ 카페')),
                    Chip(label: Text('🚶 산책')),
                    Chip(label: Text('🍲 로컬 맛집')),
                    Chip(label: Text('😌 여유로운 일정')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
