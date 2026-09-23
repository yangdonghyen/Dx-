import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import 'register_screen.dart';
import 'setup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _S();
}

class _S extends State<LoginScreen> {
  final id = TextEditingController(), pw = TextEditingController();
  String notice = '';
  void login() => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const SetupScreen()),
  );
  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(32, 48, 32, 28),
        children: [
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text('✈️', style: TextStyle(fontSize: 42)),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            '여행메이트',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          const Text(
            '나에게 맞는 여행을 시작해볼까요?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 34),
          TextField(
            controller: id,
            decoration: const InputDecoration(hintText: '아이디 또는 이메일'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: pw,
            obscureText: true,
            decoration: const InputDecoration(hintText: '비밀번호'),
          ),
          if (notice.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                notice,
                style: const TextStyle(color: AppColors.primary),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    setState(() => notice = '가입할 때 사용한 이메일을 입력해 주세요.'),
                child: const Text('아이디 찾기'),
              ),
              TextButton(
                onPressed: () =>
                    setState(() => notice = '비밀번호 재설정 안내를 받을 수 있어요.'),
                child: const Text('비밀번호 찾기'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  c,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          PrimaryButton('로그인하기', onPressed: login),
          const SizedBox(height: 22),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('또는', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            '♡  카카오로 로그인하기',
            color: Color(0xFFFFE500),
            onPressed: login,
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            '◯  네이버로 로그인하기',
            color: Color(0xFF03C75A),
            onPressed: login,
          ),
        ],
      ),
    ),
  );
}
