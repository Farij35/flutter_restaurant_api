import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/provider/resto_list_provider.dart';
import 'package:flutter_restaurant_api/provider/search_provider.dart';
import 'package:flutter_restaurant_api/common/styles.dart';
import 'package:flutter_restaurant_api/ui/list_restaurant.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(apiService: ApiService())
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(apiService: ApiService())
        ),
      ],
      child: MaterialApp(
        title: 'Restaurants',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor,
          ),
          textTheme: restoTextTheme,
        ),
        home: const RestaurantList(),
      ),
    );
  }
}