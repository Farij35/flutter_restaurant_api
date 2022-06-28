import 'dart:io';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/data/model/restaurant_search.dart';
import 'package:flutter/foundation.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
  noConnection
}

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  SearchProvider({
    required this.apiService
  }) {
    fetchQueryRestaurant(query);
  }

  RestaurantSearch? _restaurantSearch;
  ResultState? _state;
  String _message = '';
  String _query = '';
  String get message => _message;
  String get query => _query;
  RestaurantSearch? get result => _restaurantSearch;
  ResultState? get state => _state;

  Future<dynamic> fetchQueryRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;
        notifyListeners();
        final restaurantList = await apiService.restaurantSearch(query);
        if (restaurantList.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Data Kosong';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantSearch = restaurantList;
        }
      }
    } on SocketException {
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'Periksa Kembali Koneksi Anda';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}