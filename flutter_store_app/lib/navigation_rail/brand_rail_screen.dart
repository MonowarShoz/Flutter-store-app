import 'package:flutter/material.dart';
import 'package:flutter_store_app/models/product.dart';

import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class BrandRailScreen extends StatelessWidget {
  const BrandRailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prodAttr = Provider.of<Product>(context);
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: prodAttr.id);
      },
      child: Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        margin: EdgeInsets.only(right: 20.0, bottom: 5, top: 18),
        constraints: BoxConstraints(minHeight: 150, minWidth: double.infinity, maxHeight: 180),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  image: DecorationImage(
                    image: NetworkImage(prodAttr.imgUrl),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
              ),
            ),
            FittedBox(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                width: 160,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Column(
                  children: [
                    Text(
                      prodAttr.title,
                      maxLines: 4,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FittedBox(
                      child: Text(
                        'US \$ ${prodAttr.price}',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      prodAttr.prodCategoryName,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 20),
                    
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
