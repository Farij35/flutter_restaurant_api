import 'package:flutter_restaurant_api/provider/resto_list_provider.dart';
import 'package:flutter_restaurant_api/ui/favorite_restaurant.dart';
import 'package:flutter_restaurant_api/ui/search.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Restaurant'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const FavoriteRestaurant())),
            icon: const Icon(Icons.favorite),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SearchRestaurant())),
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
        ],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, state, _){
        if (state.state == ResultState.loading){
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
        } else if (state.state == ResultState.hasData){
          return StaggeredGridView.countBuilder(
            itemCount: state.result.restaurants.length,
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
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
      }),
    );
  }
}
