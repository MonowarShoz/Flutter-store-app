import 'package:flutter/material.dart';
import 'package:flutter_store_app/widgets/empty_wishlist.dart';
import 'package:flutter_store_app/widgets/full_wishlist.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List wishlistList = [];

    return wishlistList.isNotEmpty
        ? Scaffold(
            body: EmptyWishlist(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Wish List'),
            ),
            body: ListView.builder(
              itemBuilder: (BuildContext ctx, int index) {
                return FullWishListScreen();
              },
            ),
          );
  }
}
