import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import 'setup_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          AppHeader('회원가입', onBack: () => Navigator.pop(c)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  '여행메이트 시작하기',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 22),
                const TextField(decoration: InputDecoration(labelText: '이름')),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(labelText: '아이디 또는 이메일'),
                ),
                const SizedBox(height: 12),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: '비밀번호'),
                ),
                const SizedBox(height: 12),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: '비밀번호 확인'),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  '가입하고 시작하기',
                  onPressed: () => Navigator.pushReplacement(
                    c,
                    MaterialPageRoute(builder: (_) => const SetupScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
