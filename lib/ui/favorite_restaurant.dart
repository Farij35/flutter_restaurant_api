import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_favorite.dart';

class FavoriteRestaurant extends StatelessWidget {
  const FavoriteRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Favorite",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const FavoritePage(),
    );
  }
}