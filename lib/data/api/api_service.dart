import 'dart:convert';
import 'package:flutter_restaurant_api/common/url.dart';
import 'package:flutter_restaurant_api/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<RestaurantList> getRestaurants() async {
    final response = await http.get(Uri.parse(Url.baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response =
        await http.get(Uri.parse(Url.baseUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    String tempQuery = query.replaceAll(' ', '%20');
    final response =
        await http.get(Uri.parse(Url.baseUrl + "search?q=" + tempQuery));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search result');
    }
  }
}
