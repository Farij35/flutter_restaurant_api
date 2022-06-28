import 'package:flutter_restaurant_api/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class SearchRestaurant extends StatefulWidget {
  const SearchRestaurant({
    Key? key
  }) : super(key: key);

  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  String searchQuery = "";
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pencarian')),
      body: SafeArea(
        child: Column(
          children: [
            searchField(),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer<SearchProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.result!.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant = state.result!.restaurants[index];
                            return RestaurantSearchCard(restaurant: restaurant);
                          });
                    } else if (state.state == ResultState.noData) {
                      return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Icon(Icons.search_off, color: Colors.grey, size: 64),
                              SizedBox(height: 24),
                              Text('No restaurant found. Please recheck your keyword',
                                  style: TextStyle(color: Colors.grey))
                            ],
                          ));
                    } else if (state.state == ResultState.noData) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(state.message),
                            )
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.noConnection) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(state.message),
                            )
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.error) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(state.message),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchField(){
    return Consumer<SearchProvider>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 6.0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search by Resto name / Menu name",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _search,
                onChanged: (String query) {
                  if (query.isNotEmpty) {
                    setState(() {
                      searchQuery = query;
                    });
                    state.fetchQueryRestaurant(query);
                  }
                },
              ),
            ),
          ),
        );
      }
    );
  }
  //   return Column(
  //     children: <Widget>[
  //       Container(
  //         padding: const EdgeInsets.all(15),
  //         child: TextField(
  //           controller: _controller,
  //           textInputAction: TextInputAction.search,
  //           decoration: InputDecoration(
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(25.0),
  //               borderSide: const BorderSide(
  //                 color: Colors.grey,
  //               ),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(20.0),
  //               borderSide: const BorderSide(
  //                 color: Colors.blue,
  //               ),
  //             ),
  //             suffixIcon: const InkWell(
  //               child: Icon(Icons.search),
  //             ),
  //             contentPadding: EdgeInsets.all(15.0),
  //             hintText: 'Search',
  //           ),
  //           // onSubmitted: (String value) async {
  //           //   widget.query = value;
  //           // },
  //         ),
  //       ),
  //       FutureBuilder(
  //         future: _search,
  //         builder: (context, AsyncSnapshot<RestaurantSearch> snapshot){
  //           var state = snapshot.connectionState;
  //           if (state != ConnectionState.done) {
  //             return const Center(child: CircularProgressIndicator());
  //           } else {
  //             if(snapshot.hasData) {
  //               return ListView.builder(
  //                 itemCount: snapshot.data?.restaurants.length,
  //                 itemBuilder: (context, index){
  //                   var restaurant = snapshot.data?.restaurants[index];
  //                   return searchWidget(search: restaurant!, query: widget.query);
  //                 },
  //               );
  //             } else if (snapshot.hasError) {
  //               return Center(child: Text(snapshot.error.toString()));
  //             } else {
  //               return const Text('');
  //             }
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }
  //
  // Future<RestaurantSearch> restaurantSearch() async {
  //   try{
  //     final response = await http.get(
  //       Uri.parse('https://restaurant-api.dicoding.dev/search?q=${widget.query}'),
  //     );
  //     if (response.statusCode == 200) {
  //       return RestaurantSearch.fromJson(json.decode(response.body));
  //     } else {
  //       throw Exception('Failed to load Restaurant Search');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet Connection');
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}


