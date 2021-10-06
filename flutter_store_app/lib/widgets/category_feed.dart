import 'package:flutter/material.dart';

import 'package:flutter_store_app/provider/products_provider.dart';
import 'package:flutter_store_app/widgets/product_feed.dart';
import 'package:provider/provider.dart';

class CategoryFeed extends StatelessWidget {
  static const routeName = '/categoryFeed';
  const CategoryFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context, listen: false);
    
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final prodList = productProvider.findByCategory(categoryName);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Feed'),
      ),
      body: GridView.count(
        childAspectRatio: 240 / 420,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        children: List.generate(
          prodList.length,
          (index) => ChangeNotifierProvider.value(
            value: prodList[index],
            child: ProductFeed(),
          ),
        ),
      ),
    );
  }
}
