import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/info_tile.dart';

class YoutubeSavedScreen extends StatelessWidget {
  const YoutubeSavedScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('YouTube 저장 여행지'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                Text(
                  '저장한 여행 콘텐츠 12개',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                InfoTile('▶️', '안목해변', 'YouTube에서 저장'),
                InfoTile('▶️', '황리단길', 'YouTube에서 저장'),
                InfoTile('▶️', '애월 해안도로', 'YouTube에서 저장'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
