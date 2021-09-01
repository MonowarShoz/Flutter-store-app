import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';

class FullWishListScreen extends StatefulWidget {
  const FullWishListScreen({Key? key}) : super(key: key);

  @override
  _FullWishListScreenState createState() => _FullWishListScreenState();
}

class _FullWishListScreenState extends State<FullWishListScreen> {
  @override
  Widget build(BuildContext context) {
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
                      child: Image.asset('assets/images/Shoes.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'title',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '\$ 20',
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
        removeWish(),
      ],
    );
  }

  Widget removeWish() {
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          onPressed: () {},
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
