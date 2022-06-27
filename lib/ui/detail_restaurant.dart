import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/data/model/restaurants_detail.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_detail.dart';

class RestaurantDetail extends StatefulWidget {

  final String id;

  const RestaurantDetail({required this.id});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  late Future<RestaurantDetailJson> restaurantDetail;

  @override
  void initState() {
    super.initState();
    restaurantDetail = ApiService().restaurantDetailGet(widget.id);
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: restaurantDetail,
      builder: (context, AsyncSnapshot<RestaurantDetailJson> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return buildRestaurantDetail(restaurantDetail: snapshot.data!.restaurant);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Text('');
          }
        }
      }
    );
  }
}

