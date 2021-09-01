import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/themes.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/screens/bottom_bar.dart';
import 'package:flutter_store_app/navigation_rail/brand_nav_rail.dart';
import 'package:flutter_store_app/screens/cart_screen.dart';
import 'package:flutter_store_app/screens/feed_screen.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:flutter_store_app/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeProvider = DarkThemeProvider();
  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.themePreferences.getTheme();
  }
  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeStyles.themeData(themeProvider.darkTheme, context),
          home: BottomBarScreen(),
          routes: {
            BrandNavRailScreen.routeName : (ctx) => BrandNavRailScreen(),
            FeedScreen.routeName :(ctx) => FeedScreen(),
            CartScreen.routeName : (ctx) => CartScreen(),
            WishListScreen.routeName : (ctx) => WishListScreen(),
            ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
          },
        );
      }),
    );
  }
}
