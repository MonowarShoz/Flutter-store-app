import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:flutter_store_app/models/order.dart';
import 'package:flutter_store_app/provider/carts_provider.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class FullOrder extends StatefulWidget {
  const FullOrder({Key? key}) : super(key: key);

  @override
  _FullOrderState createState() => _FullOrderState();
}

class _FullOrderState extends State<FullOrder> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    ShowDialogs showDialogs = ShowDialogs();
    final cartProvider = Provider.of<CartProvider>(context);
    final orders = Provider.of<Order>(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailScreen.routeName,
        arguments: orders.productId,
      ),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(orders.imgUrl),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            orders.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showDialogs.showAlertDialog(
                                  'Remove order!', 'Order wwill be deleted!',
                                  () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await FirebaseFirestore.instance
                                    .collection('order')
                                    .doc(orders.orderId)
                                    .delete();
                              }, context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : Icon(
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
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${orders.price}\u{09F3}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        Text('Quantity:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'x${orders.quantity}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        Flexible(child: Text('Order ID:')),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            'x${orders.orderId}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
