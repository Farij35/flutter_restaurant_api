class Favorite{
  String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Favorite({
    this.id = "",
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'pictureId' : pictureId,
    'city': city,
    'rating': rating,
  };
}