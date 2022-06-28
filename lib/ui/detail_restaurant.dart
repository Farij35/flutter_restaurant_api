import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/provider/resto_detail_provider.dart';
import 'package:provider/provider.dart';

class RestaurantDetail extends StatelessWidget {
  final String id;
  const RestaurantDetail({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), id: id),
      child: Consumer<DetailProvider>(
        builder: (context, state, _){
          if(state.state == ResultState.loading){
            return const Center(
              child: CircularProgressIndicator()
            );
          } else if (state.state == ResultState.hasData){
            return Scaffold(
              appBar: AppBar(
                title: Text(state.result.restaurant.name),
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
                          Text('Location: ${state.result.restaurant.city}'),
                          const SizedBox(height: 10),
                          Text('Rate: ${state.result.restaurant.rating}'),
                          const Divider(color: Colors.grey),
                          Text(
                            state.result.restaurant.description,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const Divider(color: Colors.grey),
                          const Text('Foods Menu'),
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
                          const Text('Drinks Menu'),
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(state.message),
                  )
                ],
              ),
            );
          } else if (state.state == ResultState.noConnection) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(state.message),
                  )
                ],
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(state.message),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}