import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/model/restaurants_detail.dart';

class buildRestaurantDetail extends StatelessWidget {
  final Restaurant restaurantDetail;
  const buildRestaurantDetail({Key? key, required this.restaurantDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantDetail.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network('https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantDetail.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('Location: ${restaurantDetail.city}'),
                  const SizedBox(height: 10),
                  Text('Rate: ${restaurantDetail.rating}'),
                  const Divider(color: Colors.grey),
                  Text(
                    restaurantDetail.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const Text('Foods Menu'),
                  Column(
                    children: restaurantDetail.menus.foods.map((food) =>
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
                    children: restaurantDetail.menus.drinks.map((drink) =>
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
                      )
                    ).toList(),
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
