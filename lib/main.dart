import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/model/restaurants_detail.dart';
import 'package:flutter_restaurant_api/ui/detail_restaurant.dart';
import 'package:flutter_restaurant_api/common/styles.dart';
import 'package:flutter_restaurant_api/ui/list_restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          onPrimary: Colors.black,
          secondary: secondaryColor,
        ),
        textTheme: restoTextTheme,
      ),
      home: RestaurantList(),
    );
  }
}