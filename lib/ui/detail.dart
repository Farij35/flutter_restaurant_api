import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/provider/get_detail_provider.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
        ),
        body: SafeArea(
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network('https://restaurant-api.dicoding.dev/images/large/${state.result.restaurant.pictureId}'),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.result.restaurant.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                ),
                                const SizedBox(width: 5),
                                Text('${state.result.restaurant.address}, ${state.result.restaurant.city}'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(width: 5),
                                Text(state.result.restaurant.rating.toString()),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Text(
                              state.result.restaurant.description,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Foods Menu',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Column(
                              children: state.result.restaurant.menus.foods.map((food) =>
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
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Drinks Menu',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Column(
                              children: state.result.restaurant.menus.drinks.map((drink) =>
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
                            const Divider(color: Colors.grey),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Review',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Column(
                              children: state.result.restaurant.customerReviews.map((review) =>
                                  Card(
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      leading: const Icon(Icons.supervised_user_circle, size: 50),
                                      title: Row(
                                        children: [
                                          Text(review.name),
                                          const Spacer(),
                                          Text(review.date, style: const TextStyle(fontSize: 10, color: Colors.grey),)
                                        ],
                                      ),
                                      subtitle: Text(review.review),
                                    ),
                                  ),
                              ).toList(),
                            ),
                            const Divider(color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.state == ResultState.NoData ||
                  state.state == ResultState.Error ||
                  state.state == ResultState.NoConnection) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 8),
                      Text(state.message),
                      const SizedBox(height: 8),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Back'))
                    ],
                  ),
                );
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
        ),
      )
    );
  }
}

