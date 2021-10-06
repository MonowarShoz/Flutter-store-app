

import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/models/product.dart';
import 'package:flutter_store_app/provider/carts_provider.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/provider/favorite_provider.dart';
import 'package:flutter_store_app/provider/products_provider.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class DialogFeed extends StatelessWidget {
  final String prodId;
  const DialogFeed({Key? key, required this.prodId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prodProvider = Provider.of<Products>(context, listen: false);
    final favProvider = Provider.of<FavoriteProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final prodAttrbs = prodProvider.findById(prodId);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 5.0,
      backgroundColor: Colors.black12,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              width: double.infinity,
              child: Image.network(
                prodAttrbs.imgUrl,
                
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: dialogContent(
                        context,
                        0,
                        () => {
                              favProvider.addAndRemoveFavorite(
                                  prodId,
                                  prodAttrbs.title,
                                  prodAttrbs.price,
                                  prodAttrbs.imgUrl),
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null
                            }),
                  ),
                  Flexible(

                    child: dialogContent(
                        context,
                        1,
                        () => {
                              Navigator.pushNamed(
                                      context, ProductDetailScreen.routeName,
                                      arguments: prodAttrbs.id)
                                  .then((value) => Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null)
                            }),
                  ),
                  Flexible(
                    child: dialogContent(
                        context,
                        2,
                        cartProvider.getCartItems.containsKey(prodId)
                            ? () {}
                            : () => {
                                  cartProvider.addToCart(
                                    prodId,
                                    prodAttrbs.title,
                                    prodAttrbs.price,
                                    prodAttrbs.imgUrl,
                                  ),
                                  Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null
                                }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, Function ft) {
    final fav = Provider.of<FavoriteProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    List<IconData> _dialogIcons = [
      fav.getFavItems.containsKey(prodId)
          ? Icons.favorite
          : Icons.favorite_border,
      FontAwesome5.eye,
      Icons.shopping_cart,
    ];
    List<String> _text = [
      fav.getFavItems.containsKey(prodId) ? 'In wishlist' : 'Add to wishlist',
      'View Product',
      cart.getCartItems.containsKey(prodId) ? 'In Cart' : 'Add to cart',
    ];
    final List<Color> _colors = [
      fav.getFavItems.containsKey(prodId) ? Colors.red : Colors.black26,
      Theme.of(context).textSelectionTheme.selectionColor as Color,
      Theme.of(context).textSelectionTheme.selectionColor as Color,
    ];
    return FittedBox(
      child: Material(
        child: InkWell(
          onTap: () {
            ft();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(14),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ]),
                  child: ClipOval(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(
                        _dialogIcons[index],
                        color: _colors[index],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      _text[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: themeChange.darkTheme
                            ? Theme.of(context).disabledColor
                            : ColorsConsts.starterColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
