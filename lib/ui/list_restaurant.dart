import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/data/model/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_card.dart';
import '../widgets/restaurant_widget.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  late Future<RestaurantListJson> _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().restaurantListGet();
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _restaurant,
      builder: (context, AsyncSnapshot<RestaurantListJson> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if(snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants[index];
                return RestaurantCard(restaurant: restaurant!);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Text('');
          }
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant'),
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RestaurantWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

}
