import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/common/navigation.dart';
import 'package:flutter_restaurant_api/common/url.dart';
import 'package:flutter_restaurant_api/data/model/restaurant.dart';
import 'package:flutter_restaurant_api/provider/database_provider.dart';
import 'package:flutter_restaurant_api/ui/detail.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 100),
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () => Navigation.intentWithData(RestaurantDetailPage.routeName, restaurant.id),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Ink.image(
                              image: NetworkImage(
                                  Url.baseUrl + 'images/medium/' + restaurant.pictureId,
                              ),
                              height: 150,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 5, top: 8),
                          child: Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),
                              child: Icon(
                                Icons.location_on,
                              ),
                            ),
                            Text(
                              restaurant.city,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            isFavorited ? IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () => provider.removeFavorite(restaurant.id),
                            )
                            : IconButton(
                              icon: const Icon(Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () => provider.addFavorite(restaurant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}
