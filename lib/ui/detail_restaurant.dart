import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/model/restaurants_detail.dart';
import 'package:flutter_restaurant_api/ui/list_restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RestaurantList()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('Location: ${restaurant.city}'),
                  const SizedBox(height: 10),
                  Text('Rate: ${restaurant.rating}'),
                  const Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const Text('Foods Menu'),
                  Column(
                    children: restaurant.menus.foods.map((food) =>
                        Column(
                          children: [
                            Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.food_bank,
                                    size: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(food.name),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )).toList(),
                  ),
                  const Divider(color: Colors.grey),
                  const Text('Drinks Menu'),
                  Column(
                    children: restaurant.menus.drinks.map((drink) =>
                        Column(
                          children: [
                            Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.local_drink,
                                    size: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(drink.name),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

