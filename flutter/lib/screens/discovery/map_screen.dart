import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/app_theme.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const fallback = LatLng(35.1149, 126.8944);
  final mapController = MapController();
  LatLng position = fallback;
  bool satellite = false;
  String status = '현재 위치를 확인하고 있어요.';

  @override
  void initState() {
    super.initState();
    _locate();
  }

  Future<void> _locate() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _useFallback();
      return;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _useFallback();
      return;
    }
    try {
      final gps = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      if (!mounted) return;
      position = LatLng(gps.latitude, gps.longitude);
      setState(() => status = 'GPS 현재 위치를 표시하고 있어요.');
      mapController.move(position, 14);
    } catch (_) {
      _useFallback();
    }
  }

  void _useFallback() {
    if (!mounted) return;
    position = fallback;
    setState(() => status = 'GPS를 사용할 수 없어 송하동 기본 위치를 표시하고 있어요.');
    mapController.move(position, 14);
  }

  @override
  Widget build(BuildContext context) {
    final url = satellite
        ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
        : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '지도 탐색',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _locate,
                    icon: const Icon(Icons.my_location),
                    label: const Text('현재 위치'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('일반 지도'),
                    selected: !satellite,
                    onSelected: (_) => setState(() => satellite = false),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('위성 지도'),
                    selected: satellite,
                    onSelected: (_) => setState(() => satellite = true),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(initialCenter: position, initialZoom: 14),
                children: [
                  TileLayer(
                    urlTemplate: url,
                    userAgentPackageName: 'com.example.travel_mate',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: position,
                        width: 92,
                        height: 62,
                        child: const _MapMarker('현재 위치', Colors.green),
                      ),
                      const Marker(
                        point: LatLng(35.1168, 126.9002),
                        width: 92,
                        height: 62,
                        child: _MapMarker('카페', AppColors.primary),
                      ),
                      const Marker(
                        point: LatLng(35.1105, 126.8890),
                        width: 92,
                        height: 62,
                        child: _MapMarker('쉼터', AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: Text(
                satellite
                    ? '위성영상 출처: Esri, Maxar'
                    : '지도 출처: © OpenStreetMap 기여자',
                style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  const _MapMarker(this.label, this.color);
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
      Icon(Icons.location_on, color: color, size: 31),
    ],
  );
}
