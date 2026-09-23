import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';

class AiAnalysisScreen extends StatelessWidget {
  const AiAnalysisScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('AI 취향 분석'),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 18),
                  Text('저장한 콘텐츠로 취향을 분석해요'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
