import 'package:flutter/material.dart';

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
      'categoryName': 'Clothes',
      'imagePath': 'assets/images/Clothes.jpg',
    },
    {
      'categoryName': 'Shoes',
      'imagePath': 'assets/images/Shoes.jpg',
    },
    {
      'categoryName': 'Health & Beauty',
      'imagePath': 'assets/images/Beauty.jpg',
    },
    {
      'categoryName': 'Laptops',
      'imagePath': 'assets/images/laptop.png',
    },
    {
      'categoryName': 'Furniture',
      'imagePath': 'assets/images/Furniture.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        Positioned(
          bottom: 0,
          right: 10,
          left: 10,
          child: Container(
            padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
