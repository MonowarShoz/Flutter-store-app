

import 'package:flutter/cupertino.dart';


class Cart with ChangeNotifier{
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String imgUrl;

  Cart({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imgUrl,
  });
}
