import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/provider/resto_list_provider.dart';
import 'package:flutter_restaurant_api/provider/search_provider.dart';
import 'package:flutter_restaurant_api/common/styles.dart';
import 'package:flutter_restaurant_api/ui/list_restaurant.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_card.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_favorite.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    loadFavorite();
    super.initState();
  }
  loadFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isPressed = prefs.getBool("isPressed")!;
    });
  }

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