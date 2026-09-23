class Companion {
  const Companion({
    required this.name,
    required this.age,
    this.prefs = const [],
    this.walking = '',
    this.avoid = const [],
  });
  final String name, age, walking;
  final List<String> prefs, avoid;
}
