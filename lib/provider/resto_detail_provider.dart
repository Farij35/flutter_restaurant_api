import 'dart:io';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/data/model/restaurants_detail.dart';
import 'package:flutter/foundation.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
  noConnection
}

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  DetailProvider({
    required this.apiService,
    required this.id
  }) {
    _fetchRestaurant(id);
  }

  late RestaurantDetailJson _restaurantDetail;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  RestaurantDetailJson get result => _restaurantDetail;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetailGet(id);
      if (restaurantDetail.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data Kosong';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetail;
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