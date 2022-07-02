import 'package:flutter_restaurant_api/data/api/api_test.dart';
import 'package:flutter_restaurant_api/data/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_restaurant_api/common/url.dart';
import 'get_restaurant_list_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchRestaurant', () {
    test(
        'returns an RestaurantList class if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(Url.baseUrl + "list"))).thenAnswer(
          (_) async => http.Response(
              '{"error":false,"message":"succes","count":20, "restaurants":[]}',
              200));

      expect(
          await ApiTest(client).getRestaurants(), isA<RestaurantList>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse(Url.baseUrl + "list")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiTest(client).getRestaurants(), throwsException);
    });
  });
}
