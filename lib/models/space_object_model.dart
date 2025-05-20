class SpaceObject {
  final String name;
  String type;
  final String description;
  final String imageUrl;
  final String date;
  bool isFavorite;

  SpaceObject({
    required this.name,
    this.type = 'Unknown',
    required this.description,
    required this.imageUrl,
    required this.date,
    this.isFavorite = false,
  });
}
