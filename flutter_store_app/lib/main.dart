
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/themes.dart';

import 'package:flutter_store_app/provider/carts_provider.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/provider/favorite_provider.dart';
import 'package:flutter_store_app/provider/products_provider.dart';
import 'package:flutter_store_app/screens/auth/forget_pass.dart';
import 'package:flutter_store_app/screens/auth/login_screen.dart';
import 'package:flutter_store_app/screens/auth/sign_up_screen.dart';
import 'package:flutter_store_app/screens/auth/users_states.dart';
import 'package:flutter_store_app/screens/bottom_bar.dart';
import 'package:flutter_store_app/navigation_rail/brand_nav_rail.dart';
import 'package:flutter_store_app/screens/cart_screen.dart';
import 'package:flutter_store_app/screens/feed_screen.dart';
import 'package:flutter_store_app/screens/main_page_screen.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:flutter_store_app/screens/starting_screen.dart';
import 'package:flutter_store_app/screens/upload_screen.dart';
import 'package:flutter_store_app/screens/wishlist_screen.dart';
import 'package:flutter_store_app/widgets/category_feed.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  
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

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError){
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );

          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => themeProvider,
              ),
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavoriteProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeData, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeStyles.themeData(themeProvider.darkTheme, context),
                home: UserStates(),
                routes: {
                  BrandNavRailScreen.routeName: (ctx) => BrandNavRailScreen(),
                  FeedScreen.routeName: (ctx) => FeedScreen(),
                  CategoryFeed.routeName: (ctx) => CategoryFeed(),
                  CartScreen.routeName: (ctx) => CartScreen(),
                  BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                  WishListScreen.routeName: (ctx) => WishListScreen(),
                  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                  LoginScreen.routeName: (ctx) => LoginScreen(),
                  SignUpScreen.routeName: (ctx) => SignUpScreen(),
                  UploadScreen.routeName : (ctx) => UploadScreen(),
                  ForgetPass.routeName:(ctx) => ForgetPass(),
                  
                },
              );
            }),
          );
        });
  }
}
