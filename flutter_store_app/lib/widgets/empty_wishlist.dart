import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/screens/bottom_bar.dart';
import 'package:flutter_store_app/screens/feed_screen.dart';
import 'package:provider/provider.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
    
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/empty_wish.png'),
              ),
            ),
          ),
          Text(
            'Your Wishlist is empty',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontSize: 37,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 50),
          Text(
            'Add some products in your wishlist or Explore more'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeChange.darkTheme
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FeedScreen.routeName);
              },
              child: Text('Add a Wish'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
