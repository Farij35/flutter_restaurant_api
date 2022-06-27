import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/common/styles.dart';
import 'package:flutter_restaurant_api/data/model/restaurants.dart';
import 'package:flutter_restaurant_api/ui/detail_restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurants restaurant;

  const RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantDetail(id: restaurant.id,))),
      ),
    );
  }
}
