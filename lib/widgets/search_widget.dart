import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/model/restaurant_search.dart';
import 'package:flutter_restaurant_api/ui/detail_restaurant.dart';

class RestaurantSearchCard extends StatelessWidget {
  final Restaurants restaurant;

  const RestaurantSearchCard({
    Key? key,
    required this.restaurant
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          constraints: const BoxConstraints(minHeight: 260),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantDetail(id: restaurant.id,))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: NetworkImage(
                        'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

