import 'package:flutter/material.dart';

import 'package:flutter_store_app/screens/cart_screen.dart';
import 'package:flutter_store_app/screens/feed_screen.dart';
import 'package:flutter_store_app/screens/home_screen.dart';
import 'package:flutter_store_app/screens/search_screen.dart';
import 'package:flutter_store_app/screens/user_profile.dart';

import 'package:fluttericon/font_awesome5_icons.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List? _pages;

  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      HomeScreen(),
      FeedScreen(),
      SearchScreen(),
      CartScreen(),
      UserProfile(),
    ];
    super.initState();
  }

  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages![_selectedPageIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: selectedPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
          selectedItemColor: Colors.purple,
          showUnselectedLabels: false,
          
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.home),
              label: 'Home',
              tooltip: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.rss),
              label: 'Feed',
              tooltip: 'Feed',
            ),
            BottomNavigationBarItem(
              activeIcon: null,
              icon: Icon(null),
              
              label: 'search',
              //tooltip: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.shopping_cart),
              label: 'Cart',
              tooltip: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.user),
              label: 'User',
              tooltip: 'User',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _selectedPageIndex = 2;
            });
          },
          
          backgroundColor: Colors.purple,
          splashColor: Colors.grey,
          //hoverElevation: 10,
          tooltip: 'search',
          //hoverColor: Colors.black38,
          elevation: 5,
          child: (Icon(Icons.search)),
        ),
      ),
    );
  }
}
