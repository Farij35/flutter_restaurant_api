import 'dart:convert';
import 'package:flutter_restaurant_api/common/url.dart';
import 'package:flutter_restaurant_api/data/model/restaurant.dart';
import 'package:http/http.dart' show Client;

class ApiTest {
  final Client client;
  ApiTest(this.client);

  Future<RestaurantList> getRestaurants() async {
    final response = await client.get(Uri.parse(Url.baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }
}