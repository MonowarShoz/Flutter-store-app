import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/models/product.dart';
import 'package:flutter_store_app/provider/carts_provider.dart';
import 'package:flutter_store_app/provider/favorite_provider.dart';
import 'package:flutter_store_app/provider/products_provider.dart';
import 'package:flutter_store_app/screens/wishlist_screen.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_store_app/widgets/product_feed.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class FeedScreen extends StatefulWidget {
  static const routeName = '/Feeds';
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
   final popular = ModalRoute.of(context)!.settings.arguments;
    final productProvider = Provider.of<Products>(context,);
    List<Product> prodList = productProvider.products;
    
    if (popular == 'popular') {
       prodList = productProvider.popularProducts;
      
     }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Feeds'),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (_, favs, ch) => Badge(
              badgeColor: ColorsConsts.favBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                favs.getFavItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(WishListScreen.routeName);
                },
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
               badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                cart.getCartItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(FontAwesome5.shopping_cart),
              ),
            ),
          ),

        ],
        
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 200 / 300,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          prodList.length,
          (index) {
            return ChangeNotifierProvider.value(
              value: prodList[index],
              child: ProductFeed(),
            );
          },
        ),
      ),
//       body: StaggeredGridView.countBuilder(
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) => new ProductFeed(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
    );
  }
}
