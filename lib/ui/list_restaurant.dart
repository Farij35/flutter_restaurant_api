import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/provider/get_provider.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
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
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 8),
                  Text(state.message),
                  const SizedBox(height: 8),
                ],
              ),
            );
          } else if (state.state == ResultState.NoConnection) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(state.message),
                  const SizedBox(height: 8),
                ],
              ),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(state.message),
                  const SizedBox(height: 8),
                ],
              ),
            );
          } else {
            return const Center(child: Text(''));
          }
        }
      ),
    );
  }
}
