import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:flutter_store_app/provider/order_provider.dart';
import 'package:flutter_store_app/widgets/cart_widget/empty_cart.dart';
import 'package:flutter_store_app/widgets/full_order.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    ShowDialogs showDialogs = ShowDialogs();
    final orderProvider = Provider.of<OrderProvider>(context);

    return FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          return orderProvider.orderItems.isEmpty
              ? Scaffold(
                  appBar: AppBar(),
                  body: EmptyCart(
                    title: 'Your Order is Empty',
                    subTitle:
                        'Looks like you didn\'t \n order any product from your cart',
                    btnTitle: 'Order Now',
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: Text(
                      'Orders ${orderProvider.orderItems.length}',
                    ),
                    actions: [],
                  ),
                  body: Container(
                    child: ListView.builder(
                      itemCount: orderProvider.orderItems.length,
                        itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                        value: orderProvider.orderItems[index],
                        child: FullOrder(),
                      );
                    }),
                  ),
                );
        });
  }
}
