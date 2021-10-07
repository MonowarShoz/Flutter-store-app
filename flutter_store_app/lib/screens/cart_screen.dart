import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/provider/carts_provider.dart';
import 'package:flutter_store_app/widgets/cart_widget/empty_cart.dart';
import 'package:flutter_store_app/widgets/cart_widget/full_cart.dart';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/Cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ShowDialogs showDialogs = ShowDialogs();
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            appBar: AppBar(),
            body: EmptyCart(
              title: 'Your Cart is Empty',
              subTitle: 'Looks like you don\'t \n have any product in your cart',
              btnTitle: 'Shop Now',
            ),
          )
        : Scaffold(
            bottomSheet: checkOut(context, cartProvider.totalAmount),
            appBar: AppBar(
              title: Text('Cart Items ${cartProvider.getCartItems.length}'),
              actions: [
                IconButton(
                  onPressed: () {
                    showDialogs.showAlertDialog(
                        'Remove Cart',
                        'Cart will be empty',
                        () => cartProvider.clearCart(),
                        context);
                  },
                  icon: Icon(FontAwesome5.trash),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: FullCart(
                        prodId: cartProvider.getCartItems.keys.toList()[index],
                      ),
                    );
                  }),
            ),
          );
  }

  Widget checkOut(BuildContext ctx, int subTotal) {
    var uuid = Uuid(); 
    final FirebaseAuth _auth= FirebaseAuth.instance;
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      ColorsConsts.gradiendFStart,
                      ColorsConsts.gradiendLEnd,
                    ],
                    stops: [0.0, 0.7],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async{
                      
                      User? user = _auth.currentUser;
                      final _uid = user!.uid;
                      cartProvider.getCartItems.forEach((key, value) async{ 
                        final orderId = uuid.v4();
                        await FirebaseFirestore.instance.collection('order').doc(orderId).set({
                        'orderId': orderId,
                        'userId': _uid,
                        'productId': value.prodId,
                        'title': value.title,
                        'price': value.price,
                        'imgUrl':value.imgUrl,
                        'quantity':value.quantity,
                        'orderDate':Timestamp.now(),

                      });

                      });
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Check Out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              Theme.of(ctx).textSelectionTheme.selectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total: ',
              style: TextStyle(
                color: Theme.of(ctx).textSelectionTheme.selectionColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Us \$ $subTotal',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
