import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class PopularProducts extends StatefulWidget {
 
  const PopularProducts({Key? key,  }) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      
      child: Container(
        
        width: width * 0.5,
        
        
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(
              10.0,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            onTap: () {},
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.2,
                     
                      
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Shoes.jpg'),
                          fit: BoxFit.fill,

                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Positioned(
                      right: 12,
                      top: 10,
                      child: Icon(
                        Icons.star_border,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 7,
                      child: Icon(
                        Icons.star_border_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ 20',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  
                  
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'title',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                         
                          Material(
                            color: Colors.transparent,
                            
                            child: InkWell(
                              onTap: (){},
                              borderRadius: BorderRadius.circular(30.0),
                              child: Padding(
                                padding:const EdgeInsets.all(8),
                                child: Icon(
                                  FontAwesome5.cart_plus,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
