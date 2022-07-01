import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/data/model/restaurant_favorite.dart';
import 'package:flutter_restaurant_api/ui/detail_restaurant.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Favorited>>(
        stream: readFavorite(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('Terjadi Kesalahan! ${snapshot.error}');
          } else if (snapshot.hasData){
            return ListView(
              children: snapshot.data!.map((favorite) => Padding(
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantDetail(id: favorite.id))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Ink.image(
                                image: NetworkImage(
                                  'https://restaurant-api.dicoding.dev/images/medium/${favorite.pictureId}',
                                ),
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
                            child: Text(
                              favorite.name,
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
                                favorite.city,
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
                                favorite.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  final deleteFavorite = FirebaseFirestore
                                      .instance
                                      .collection('favorite')
                                      .doc(favorite.id);
                                  deleteFavorite.delete();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Stream<List<Favorited>> readFavorite() =>
      FirebaseFirestore.instance
          .collection('favorite')
          .orderBy('date')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Favorited.fromJson(doc.data())).toList()
      );
}