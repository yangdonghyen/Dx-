class Place {
  const Place({
    required this.id,
    required this.name,
    required this.region,
    required this.tags,
    required this.image,
  });
  final String id, name, region, image;
  final List<String> tags;
}
