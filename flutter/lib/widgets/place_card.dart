import 'package:flutter/material.dart';
import '../models/place.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard(this.place, {super.key, this.onTap});
  final Place place;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext c) => Card(
    color: Colors.white,
    elevation: 0,
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(child: Text(place.name == '안목해변' ? '🌊' : '📍')),
      title: Text(
        place.name,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text('${place.region}\n${place.tags.join(' · ')}'),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}
