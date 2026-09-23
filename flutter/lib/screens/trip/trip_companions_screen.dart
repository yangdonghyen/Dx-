import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';

class TripCompanionsScreen extends StatelessWidget {
  const TripCompanionsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('동행자 조건'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                TextField(decoration: InputDecoration(labelText: '동행자 이름')),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: '연령대')),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: '걷기/휴식 참고사항')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
