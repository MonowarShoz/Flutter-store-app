import 'package:flutter/cupertino.dart';
import 'package:flutter_store_app/models/favorite.dart';

class FavoriteProvider with ChangeNotifier {
  Map<String, Favourite> _favoriteItems = {};

  Map<String, Favourite> get getFavItems {
    return {..._favoriteItems};
  }

  void addAndRemoveFavorite(
      String prodId, String title, int price, String imgUrl) {
    if (_favoriteItems.containsKey(prodId)) {
      removeItem(prodId);
    } else {
      _favoriteItems.putIfAbsent(
          prodId,
          () => Favourite(
                id: DateTime.now().toString(),
                price: price,
                imgUrl: imgUrl,
                title: title,
              ));
    }
    notifyListeners();
  }

  void removeItem(String prodId) {
    _favoriteItems.remove(prodId);
    notifyListeners();
  }
  void clearFavorite(){
    _favoriteItems.clear();
    notifyListeners();
  }
}
