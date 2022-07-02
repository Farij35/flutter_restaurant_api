import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_restaurant_api/common/navigation.dart';
import 'package:flutter_restaurant_api/common/styles.dart';
import 'package:flutter_restaurant_api/data/api/api_service.dart';
import 'package:flutter_restaurant_api/data/db/database_helper.dart';
import 'package:flutter_restaurant_api/data/preferences/preferences_helper.dart';
import 'package:flutter_restaurant_api/provider/database_provider.dart';
import 'package:flutter_restaurant_api/provider/get_provider.dart';
import 'package:flutter_restaurant_api/provider/preferences_provider.dart';
import 'package:flutter_restaurant_api/provider/scheduling_provider.dart';
import 'package:flutter_restaurant_api/provider/search_provider.dart';
import 'package:flutter_restaurant_api/ui/detail.dart';
import 'package:flutter_restaurant_api/ui/favorite.dart';
import 'package:flutter_restaurant_api/ui/home.dart';
import 'package:flutter_restaurant_api/ui/list_restaurant.dart';
import 'package:flutter_restaurant_api/ui/search.dart';
import 'package:flutter_restaurant_api/ui/setting.dart';
import 'package:flutter_restaurant_api/utils/background_service.dart';
import 'package:flutter_restaurant_api/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Restaurants',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor,
          ),
          textTheme: restoTextTheme,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          RestaurantList.routeName: (context) => const RestaurantList(),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          SettingScreen.routeName: (context) => const SettingScreen(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}

