import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/alert_dialog.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/models/favorite.dart';
import 'package:flutter_store_app/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FullWishListScreen extends StatefulWidget {
  final String prodId;
  const FullWishListScreen({Key? key, required this.prodId}) : super(key: key);

  @override
  _FullWishListScreenState createState() => _FullWishListScreenState();
}

class _FullWishListScreenState extends State<FullWishListScreen> {
  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<Favourite>(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      child: Image.network(
                        favourite.imgUrl,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          favourite.title,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '\$ ${favourite.price}',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        removeWish(widget.prodId),
      ],
    );
  }

  Widget removeWish(String prodId) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    ShowDialogs showDialogs = ShowDialogs();
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          onPressed: () {
            showDialogs.showAlertDialog(
              'Clear Wishlist',
              'item will be removed',
              () => favProvider.removeItem(prodId),
              context,
            );
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(0.0),
          color: ColorsConsts.favColor,
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
