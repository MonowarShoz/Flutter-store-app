import 'package:flutter/material.dart';
import 'package:flutter_store_app/models/product.dart';
import 'package:flutter_store_app/provider/carts_provider.dart';
import 'package:flutter_store_app/provider/favorite_provider.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final prodAttr = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavoriteProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Container(
        width: width * 0.5,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(
              10.0,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: prodAttr.id);
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(prodAttr.imgUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Positioned(
                      right: 12,
                      top: 10,
                      child: Icon(
                          Icons.star,
                        color:favProvider.getFavItems.containsKey(prodAttr.id) ? Colors.red : Colors.grey.shade800,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 7,
                      child: Icon(
                        Icons.star_border,
                        color:  Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\u{09F3} ${prodAttr.price}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prodAttr.title,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              prodAttr.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: cartProvider.getCartItems
                                        .containsKey(prodAttr.id)
                                    ? () {}
                                    : () {
                                        cartProvider.addToCart(
                                          prodAttr.id,
                                          prodAttr.title,
                                          prodAttr.price,
                                          prodAttr.imgUrl,
                                        );
                                      },
                                borderRadius: BorderRadius.circular(30.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 18,bottom: 5),
                                  child: Icon(
                                   cartProvider.getCartItems.containsKey(prodAttr.id) ? FontAwesome5.check : FontAwesome5.cart_plus,
                                    size: 30,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
