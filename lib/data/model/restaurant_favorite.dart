import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite{
  String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final DateTime date;

  Favorite({
    this.id = "",
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'pictureId': pictureId,
    'city': city,
    'rating': rating,
    'date': date,
  };
}

class Favorited{
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final DateTime date;

  Favorited({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.date,
  });

  static Favorited fromJson(Map<String, dynamic> json) => Favorited(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    pictureId: json['pictureId'],
    city: json['city'],
    rating: json['rating'],
    date: (json['date'] as Timestamp).toDate(),
  );
}