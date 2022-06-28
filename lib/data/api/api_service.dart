import 'dart:convert';
import 'dart:io';
import 'package:flutter_restaurant_api/data/model/restaurant_search.dart';
import 'package:flutter_restaurant_api/data/model/restaurants_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_restaurant_api/data/model/restaurants.dart';

class ApiService {

  Future<RestaurantListJson> restaurantListGet() async {
    final response = await http.get(
      Uri.parse('https://restaurant-api.dicoding.dev/list'),
    );
    if (response.statusCode == 200) {
      return RestaurantListJson.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<RestaurantDetailJson> restaurantDetailGet(String id) async {
    try{
      final response = await http.get(
        Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'),
      );
      if (response.statusCode == 200) {
        return RestaurantDetailJson.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Restaurant Detail');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RestaurantSearch> restaurantSearch(String query) async {
    String querySpace = query.replaceAll((' '), '%20');
    try{
      final response = await http.get(
        Uri.parse('https://restaurant-api.dicoding.dev/search?q=$querySpace'),
      );
      if (response.statusCode == 200) {
        return RestaurantSearch.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Restaurant Search');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RestaurantListJson> restaurantGet() async {
    try{
      final response = await http.get(
        Uri.parse('https://restaurant-api.dicoding.dev/list'),
      );
      if (response.statusCode == 200) {
        return RestaurantListJson.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Restaurant List');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception(e);
    }
  }

}