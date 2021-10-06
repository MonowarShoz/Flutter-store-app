import 'package:flutter/material.dart';
import 'package:flutter_store_app/screens/bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomBarScreen(),
      ],
    );
  }
}