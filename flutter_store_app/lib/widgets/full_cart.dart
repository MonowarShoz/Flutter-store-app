import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';

import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/models/cart.dart';

import 'package:flutter_store_app/provider/carts_provider.dart';

import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class FullCart extends StatefulWidget {
  final String prodId;
  const FullCart({Key? key, required this.prodId}) : super(key: key);

  @override
  _FullCartState createState() => _FullCartState();
}

class _FullCartState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartModel = Provider.of<Cart>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    var subTotal = cartModel.price * cartModel.quantity;

    ShowDialogs showDialogs = ShowDialogs();
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: const Radius.circular(16.0),
          topRight: const Radius.circular(16.0),
        ),
        color: themeChange.darkTheme ? Colors.grey.shade200 : Colors.white,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: widget.prodId);
            },
            child: Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cartModel.imgUrl),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          cartModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: themeChange.darkTheme
                                  ? Colors.blue
                                  : Colors.black),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            showDialogs.showAlertDialog(
                                'Remove Item',
                                'Product will be discarded from the cart',
                                () => cartProvider.removeCart(widget.prodId),
                                context);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              FontAwesome5.trash_restore,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                            color: themeChange.darkTheme
                                ? Colors.blue
                                : Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${cartModel.price}\$',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeChange.darkTheme
                                ? Colors.blue
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Sub Total:',
                        style: TextStyle(
                            color: themeChange.darkTheme
                                ? Colors.blue
                                : Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${subTotal.toStringAsFixed(2)} \$',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeChange.darkTheme
                                ? Colors.brown.shade900
                                : Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Ships Free',
                        style: TextStyle(
                          color: themeChange.darkTheme
                              ? Colors.brown.shade900
                              : Theme.of(context).accentColor,
                        ),
                      ),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: cartModel.quantity < 2
                              ? null
                              : () {
                                  cartProvider.reduceFromCart(
                                    widget.prodId,
                                    cartModel.title,
                                    cartModel.price,
                                    cartModel.imgUrl,
                                  );
                                },
                          borderRadius: BorderRadius.circular(4.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                FontAwesome5.minus,
                                color: cartModel.quantity < 2
                                    ? Colors.grey
                                    : Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 12,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorsConsts.gradiendFStart,
                              ColorsConsts.gradiendLEnd,
                            ], stops: [
                              0.0,
                              0.7
                            ]),
                          ),
                          child: Text(
                            cartModel.quantity.toString(),
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            cartProvider.addToCart(
                              widget.prodId,
                              cartModel.title,
                              cartModel.price,
                              cartModel.imgUrl,
                            );
                          },
                          borderRadius: BorderRadius.circular(4.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                FontAwesome5.plus,
                                color: Colors.red,
                                size: 20,
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
          ),
        ],
      ),
    );
  }
}
