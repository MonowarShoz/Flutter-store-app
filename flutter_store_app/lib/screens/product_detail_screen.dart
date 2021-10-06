import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/provider/carts_provider.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/provider/favorite_provider.dart';
import 'package:flutter_store_app/provider/products_provider.dart';
import 'package:flutter_store_app/screens/cart_screen.dart';
import 'package:flutter_store_app/screens/wishlist_screen.dart';

import 'package:flutter_store_app/widgets/product_feed.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/ProductDetail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final prodData = Provider.of<Products>(context);
    final prodList = prodData.products;
    final prodId = ModalRoute.of(context)!.settings.arguments as String;
    final prodAttr = prodData.findById(prodId);

    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          prodAttr.title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        ),
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
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              prodAttr.imgUrl,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              prodAttr.title,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '\u{09F3} ${prodAttr.price}',
                            style: TextStyle(
                              color: themeState.darkTheme
                                  ? Theme.of(context).disabledColor
                                  : ColorsConsts.subTitle,
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        prodAttr.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 21.0,
                          color: themeState.darkTheme
                              ? Theme.of(context).disabledColor
                              : ColorsConsts.subTitle,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      _prodDetails(
                          themeState.darkTheme, 'Brand : ', prodAttr.brand),
                      _prodDetails(themeState.darkTheme, 'Stock : ',
                          '${prodAttr.quantity}'),
                      _prodDetails(themeState.darkTheme, 'Category : ',
                          prodAttr.prodCategoryName),
                      _prodDetails(themeState.darkTheme, 'Popularity : ',
                          prodAttr.isPopular ? 'Popular' : 'not Popular'),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConsts.subTitle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Suggestion',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        margin: EdgeInsets.only(bottom: 30),
                        width: double.infinity,
                        height: 300,
                        child: ListView.builder(
                          itemCount: prodList.length < 6 ? prodList.length : 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return ChangeNotifierProvider.value(
                              value: prodList[index],
                              child: ProductFeed(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed:
                                cartProvider.getCartItems.containsKey(prodId)
                                    ? () {}
                                    : () {
                                        cartProvider.addToCart(
                                            prodId,
                                            prodAttr.title,
                                            prodAttr.price,
                                            prodAttr.imgUrl);
                                      },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                            ),
                            child: Text(
                              cartProvider.getCartItems.containsKey(prodId)
                                  ? 'In Cart'
                                  : 'ADD TO CART',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).backgroundColor,
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                            ),
                            icon: Icon(
                              Icons.payment,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            label: Text(
                              'buy now'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              favProvider.addAndRemoveFavorite(
                                prodId,
                                prodAttr.title,
                                prodAttr.price,
                                prodAttr.imgUrl,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                            ),
                            icon: Icon(
                              favProvider.getFavItems.containsKey(prodId)
                                  ? Icons.favorite
                                  : FontAwesome5.heart,
                              color: favProvider.getFavItems.containsKey(prodId)
                                  ? Colors.red
                                  : Colors.purple,
                            ),
                            label: Text(
                              '',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeState.darkTheme
                                    ? Theme.of(context).disabledColor
                                    : ColorsConsts.subTitle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _prodDetails(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0,
              ),
            ),
            Text(
              info,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
                color: themeState
                    ? Theme.of(context).disabledColor
                    : ColorsConsts.subTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
