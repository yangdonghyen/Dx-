import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen.dart';

/// 로그인 직후 원본 웹과 동일하게 복수 취향과 시니어 모드를 설정한다.
class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});
  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final prefs = <String>{'바다', '맛집', '카페'};
  String style = '여유롭게';
  bool senior = true;
  static const items = [
    ('🌊', '바다'),
    ('🌿', '자연'),
    ('🏙️', '도시'),
    ('🏯', '전통문화'),
    ('🍲', '맛집'),
    ('☕', '카페'),
    ('🖼️', '전시'),
    ('🎨', '체험'),
    ('🛋️', '휴식'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              children: [
                const Text(
                  '여행 취향을 알려주세요',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 5),
                const Text(
                  '나중에 언제든 바꿀 수 있어요.',
                  style: TextStyle(color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 22),
                const Text(
                  '여행 스타일',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                Row(
                  children: ['여유롭게', '알차게', '맛집 중심']
                      .map(
                        (value) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: value == '맛집 중심' ? 0 : 8,
                            ),
                            child: ChoiceChip(
                              label: Center(child: Text(value)),
                              selected: style == value,
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: style == value
                                    ? Colors.white
                                    : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (_) => setState(() => style = value),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '여행 취향 선택',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '원하는 항목을 여러 개 골라주세요.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Chip(label: Text('복수 선택 가능')),
                        ],
                      ),
                      const SizedBox(height: 14),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.02,
                            ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final selected = prefs.contains(item.$2);
                          return Material(
                            color: selected
                                ? AppColors.soft
                                : const Color(0xFFF9FAFF),
                            borderRadius: BorderRadius.circular(18),
                            child: InkWell(
                              onTap: () => setState(
                                () => selected
                                    ? prefs.remove(item.$2)
                                    : prefs.add(item.$2),
                              ),
                              borderRadius: BorderRadius.circular(18),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item.$1,
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item.$2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                            color: selected
                                                ? AppColors.primary
                                                : AppColors.ink,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (selected)
                                    const Positioned(
                                      right: 7,
                                      top: 7,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: AppColors.primary,
                                        child: Icon(
                                          Icons.check,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    '시니어 모드',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  subtitle: const Text('글자와 터치 영역을 더 크게 표시해요.'),
                  value: senior,
                  onChanged: (value) => setState(() => senior = value),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: PrimaryButton(
              '시작하기',
              onPressed: prefs.isEmpty
                  ? null
                  : () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(seniorMode: senior),
                      ),
                      (_) => false,
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}
