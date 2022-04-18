import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class RestaurantWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;

  RestaurantWidget({required this.androidBuilder, required this.iosBuilder});

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iosBuilder(context);
      default:
        return androidBuilder(context);
    }
  }
}