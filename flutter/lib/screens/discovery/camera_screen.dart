import 'package:flutter/material.dart';
import 'analyzing_screen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: IconButton(
              onPressed: () => Navigator.pop(c),
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(38),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(28),
              ),
              alignment: Alignment.center,
              child: const Text(
                '사진 속 여행지를 화면에 맞춰주세요',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  c,
                  MaterialPageRoute(builder: (_) => const AnalyzingScreen()),
                ),
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
