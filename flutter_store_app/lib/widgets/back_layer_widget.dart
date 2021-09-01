import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/screens/cart_screen.dart';
import 'package:flutter_store_app/screens/feed_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class BackLayerMenuScreen extends StatelessWidget {
  const BackLayerMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsConsts.starterColor,
                ColorsConsts.endColor,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        Positioned(
          top: -100.0,
          left: 140.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ),
        Positioned(
          top: -0.0,
          left: 100.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -50.0,
          left: 60.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Beauty.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                backLayerContent(
                  context,
                  () {
                    navigateTo(context, FeedScreen.routeName);
                  },
                  'Feeds',
                  0,
                ),
                backLayerContent(
                  context,
                  () {
                    navigateTo(context, FeedScreen.routeName);
                  },
                  'Wishlist',
                  1,
                ),
                backLayerContent(
                  context,
                  () {
                    navigateTo(context, CartScreen.routeName);
                  },
                  'Cart',
                  2,
                ),
                backLayerContent(
                  context,
                  () {
                    navigateTo(context, FeedScreen.routeName);
                  },
                  'Upload',
                  3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void navigateTo(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(
      routeName,
    );
  }

 static const List backLContentIcon = [
    FontAwesome5.rss,
    FontAwesome5.shopping_bag,
    FontAwesome5.heart,
    FontAwesome5.upload,
  ];

  Widget backLayerContent(
      BuildContext ctx, Function fn, String text, int index) {
    return InkWell(
      onTap: (){
        fn();
      },
      child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(backLContentIcon[index]),
        ],
      ),
    );
  }
}
