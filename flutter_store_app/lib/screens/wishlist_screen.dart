import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:flutter_store_app/provider/favorite_provider.dart';
import 'package:flutter_store_app/widgets/empty_wishlist.dart';
import 'package:flutter_store_app/widgets/full_wishlist.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    ShowDialogs showDialogs = ShowDialogs();

    return favProvider.getFavItems.isEmpty
        ? Scaffold(
            body: EmptyWishlist(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Wish List (${favProvider.getFavItems.length})'),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialogs.showAlertDialog(
                          'Delete WishList',
                          'Wishlist will be cleared',
                          () => favProvider.clearFavorite(),
                          context);
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
            body: ListView.builder(
              itemCount: favProvider.getFavItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                  value: favProvider.getFavItems.values.toList()[index],
                  child: FullWishListScreen(
                    prodId: favProvider.getFavItems.keys.toList()[index],
                  ),
                );
              },
            ),
          );
  }
}
