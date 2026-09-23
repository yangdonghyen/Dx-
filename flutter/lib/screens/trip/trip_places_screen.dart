import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/place_card.dart';
import '../../models/place.dart';

class TripPlacesScreen extends StatelessWidget {
  const TripPlacesScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const AppHeader('장소 선택'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                Text(
                  '가고 싶은 장소를 골라주세요',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                ),
                PlaceCard(
                  Place(
                    id: 'p1',
                    name: '안목해변',
                    region: '강원 강릉시',
                    tags: ['바다', '카페'],
                    image: '',
                  ),
                ),
                PlaceCard(
                  Place(
                    id: 'p5',
                    name: '전주 한옥마을',
                    region: '전북 전주시',
                    tags: ['전통', '맛집'],
                    image: '',
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
