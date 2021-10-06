import 'package:flutter/material.dart';

import 'package:flutter_store_app/widgets/category_feed.dart';

class CategoryWidget extends StatefulWidget {
  final int index;
  const CategoryWidget({Key? key, required this.index}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Phones',
      'imagePath': 'assets/images/Phones.png',
    },
    {
      'categoryName': 'Monitor',
      'imagePath': 'assets/images/monitor.jpg',
    },
    {
      'categoryName': 'accessories',
      'imagePath': 'assets/images/accessories.jpg',
    },
    {
      'categoryName': 'Laptops',
      'imagePath': 'assets/images/laptop.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoryFeed.routeName,
                arguments: '${categories[widget.index]['categoryName']}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('${categories[widget.index]['imagePath']}'),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          left: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              '${categories[widget.index]['categoryName']}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
