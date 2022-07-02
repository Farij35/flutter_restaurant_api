import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/provider/search_provider.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';


class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
        ),
      body: SafeArea(
        child: Column(
          children: [
            searchField(),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer<SearchRestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.result!.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result!.restaurants[index];
                        return RestaurantCard(restaurant: restaurant);
                      }
                    );
                  } else if (state.state == ResultState.NoData) {
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
                      )
                    );
                  } else if (state.state == ResultState.NoConnection) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(state.message),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  } else if (state.state == ResultState.Error) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(state.message),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text(''));
                  }
                }
              ),
            )
          ]
        ),
      )
    );
  }

  Widget searchField(){
    return Consumer<SearchRestaurantProvider>(
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
