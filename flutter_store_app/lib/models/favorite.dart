import 'package:flutter/cupertino.dart';

class Favourite with ChangeNotifier {
  final String id;
  final String title;
  final String imgUrl;
  final int price;

  Favourite({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.price,
  });
}
