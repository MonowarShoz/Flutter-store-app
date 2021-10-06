import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imgUrl;
  final String prodCategoryName;
  final String brand;
  final int quantity;
  final bool isFavorite;
  final bool isPopular;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imgUrl,
    required this.prodCategoryName,
    required this.brand,
    required this.quantity,
    this.isFavorite = false,
    required this.isPopular,
  });
}
