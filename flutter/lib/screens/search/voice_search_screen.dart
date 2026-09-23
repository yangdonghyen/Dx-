import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';

class VoiceSearchScreen extends StatelessWidget {
  const VoiceSearchScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('말로 여행지 찾기'),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.mic, size: 70),
                  SizedBox(height: 15),
                  Text(
                    '찾고 싶은 여행지를 말해보세요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
