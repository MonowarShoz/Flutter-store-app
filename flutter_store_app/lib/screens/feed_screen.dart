import 'package:flutter/material.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_store_app/widgets/product_feed.dart';

class FeedScreen extends StatelessWidget {
  static const routeName = '/Feeds';
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Screen'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 290,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          100,
          (index) => ProductFeed(),
        ),
      ),
//       body: StaggeredGridView.countBuilder(
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) => new ProductFeed(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
    );
  }
}
