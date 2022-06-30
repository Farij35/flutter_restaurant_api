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
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
      ),
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
                          Icon(
                            Icons.search_off,
                            color: Colors.grey,
                            size: 60),
                          SizedBox(height: 24),
                          Text('Your search was not found.',
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                    );
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
                    return const Center(child: Text('Find Something'));
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
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: const InkWell(
                    child: Icon(Icons.search),
                  ),
                  contentPadding: const EdgeInsets.all(15.0),
                  hintText: 'Search',
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
          ],
        );
      }
    );
  }
}




