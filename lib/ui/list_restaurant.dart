import 'package:flutter_restaurant_api/provider/resto_list_provider.dart';
import 'package:flutter_restaurant_api/ui/search.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_api/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SearchRestaurant())),
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
        ],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, state, _){
        if (state.state == ResultState.loading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData){
          return StaggeredGridView.countBuilder(
            itemCount: state.result.restaurants.length,
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
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
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}


// class RestaurantList extends StatefulWidget {
//   const RestaurantList({Key? key}) : super(key: key);
//
//   @override
//   _RestaurantListState createState() => _RestaurantListState();
// }
//
// class _RestaurantListState extends State<RestaurantList> {
//   late Future<RestaurantListJson> _restaurant;
//
//   @override
//   void initState() {
//     super.initState();
//     _restaurant = ApiService().restaurantListGet();
//   }
//
//   Widget _buildList(BuildContext context) {
//     return FutureBuilder(
//       future: _restaurant,
//       builder: (context, AsyncSnapshot<RestaurantListJson> snapshot) {
//         var state = snapshot.connectionState;
//         if (state != ConnectionState.done) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           if(snapshot.hasData) {
//             return StaggeredGridView.countBuilder(
//               itemCount: snapshot.data?.restaurants.length,
//               staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
//               crossAxisCount: 4,
//               mainAxisSpacing: 4,
//               crossAxisSpacing: 4,
//               itemBuilder: (context, index) {
//                 var restaurant = snapshot.data?.restaurants[index];
//                 return RestaurantCard(restaurant: restaurant!);
//               },
//             );
//             // return ListView.builder(
//             //   shrinkWrap: true,
//             //   itemCount: snapshot.data?.restaurants.length,
//             //   itemBuilder: (context, index) {
//             //     var restaurant = snapshot.data?.restaurants[index];
//             //     return RestaurantCard(restaurant: restaurant!);
//             //   },
//             // );
//           } else if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           } else {
//             return const Text('');
//           }
//         }
//       },
//     );
//   }
//
//   Widget _buildAndroid(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Restaurant'),
//         actions: [
//           IconButton(
//             onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchRestaurant())),
//             icon: const Icon(Icons.search),
//             color: Colors.black,
//           ),
//         ],
//       ),
//       body: _buildList(context),
//     );
//   }
//
//   Widget _buildIos(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('Restaurant'),
//       ),
//       child: _buildList(context),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RestaurantWidget(
//       androidBuilder: _buildAndroid,
//       iosBuilder: _buildIos,
//     );
//   }
//
// }
