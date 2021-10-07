import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Order with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String title;
  final int price;
  final String imgUrl;
  final int quantity;
  final Timestamp ordDate;

  Order({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.title,
    required this.price,
    required this.imgUrl,
    required this.quantity,
    required this.ordDate,
  });
}
