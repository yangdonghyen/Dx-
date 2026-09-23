import 'package:flutter/material.dart';
import 'place_result_screen.dart';

class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});
  @override
  State<AnalyzingScreen> createState() => _S();
}

class _S extends State<AnalyzingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PlaceResultScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext c) => const Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'AI가 장소를 분석하고 있어요',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}
