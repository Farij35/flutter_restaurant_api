import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/model/restaurant_favorite.dart';
import 'package:flutter_restaurant_api/data/model/restaurants.dart';
import 'package:flutter_restaurant_api/ui/detail_restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantCard extends StatefulWidget {
  final Restaurants restaurant;

  const RestaurantCard({
    Key? key,
    required this.restaurant
  }) : super(key: key);

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

bool isPressed = false;

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    @override
    savedPressed() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isPressed", isPressed);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          constraints: const BoxConstraints(minHeight: 270),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantDetail(id: widget.restaurant.id,))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: NetworkImage(
                        'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
                      ),
                      height: 150,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
                  child: Text(
                    widget.restaurant.name,
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
                      widget.restaurant.city,
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
                      widget.restaurant.rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if(isPressed == false) {
                          setState(() {
                            isPressed= true;
                            final input = FirebaseFirestore.instance.collection('favorite').doc(widget.restaurant.id);
                            final savedInput = Favorite(
                              id: widget.restaurant.id,
                              name: widget.restaurant.name,
                              description: widget.restaurant.description,
                              pictureId: widget.restaurant.pictureId,
                              city: widget.restaurant.city,
                              rating: widget.restaurant.rating,
                              date: DateTime.now(),
                            );
                            final json = savedInput.toJson();
                            input.set(json);
                            savedPressed();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Added to favorite'),
                            ));
                          });
                        } else if(isPressed == true){
                          setState(() {
                            isPressed= false;
                            final deleteFavorite = FirebaseFirestore.instance
                                .collection('favorite')
                                .doc(widget.restaurant.id);
                            deleteFavorite.delete();
                            savedPressed();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Deleted from favorite'),
                            ));
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
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
