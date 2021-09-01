import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/widgets/empty_cart.dart';
import 'package:flutter_store_app/widgets/full_cart.dart';

class CartScreen extends StatelessWidget {
   static const routeName = '/ Cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List products = [];
    return products.isNotEmpty
        ? Scaffold(
            body: EmptyCart(),
          )
        : Scaffold(
            bottomSheet: checkOut(context),
            appBar: AppBar(
              title: Text('Cart Items'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ListView.builder(itemCount: 5,itemBuilder: (BuildContext ctx, int index){
                return FullCart();
              }),
            ),
          );
  }

  Widget checkOut(BuildContext ctx) {
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
                    stops: [0.0,0.7],
                  ),

                ),
                child: Material(
                  
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Check Out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(ctx).textSelectionTheme.selectionColor,
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
              'Us\$23',
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
