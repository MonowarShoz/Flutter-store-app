import 'package:flutter/material.dart';
import 'package:flutter_store_app/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartItems = {};

  Map<String, Cart> get getCartItems {
    return {..._cartItems};
  }

  int get totalAmount {
    var total = 0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addToCart(String prodId, String title, int price, String imgUrl) {
    if (_cartItems.containsKey(prodId)) {
      _cartItems.update(
          prodId,
          (existingCartItem) => Cart(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + 1,
                price: existingCartItem.price,
                imgUrl: existingCartItem.imgUrl,
              ));
    } else {
      _cartItems.putIfAbsent(
          prodId,
          () => Cart(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
                imgUrl: imgUrl,
              ));
    }
    notifyListeners();
  }

  void reduceFromCart(String prodId, String title, int price, String imgUrl) {
    if (_cartItems.containsKey(prodId)) {
      _cartItems.update(
          prodId,
          (existingCartItem) => Cart(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price,
                imgUrl: existingCartItem.imgUrl,
              ));
    }
    notifyListeners();
  }

  void removeCart(String prodId){
    _cartItems.remove(prodId);
    notifyListeners();
  }
   void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
