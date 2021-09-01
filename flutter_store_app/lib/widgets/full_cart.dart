import 'package:flutter/material.dart';

import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/consts/themes.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class FullCart extends StatefulWidget {
  const FullCart({Key? key}) : super(key: key);

  @override
  _FullCartState createState() => _FullCartState();
}

class _FullCartState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: const Radius.circular(16.0),
          topRight: const Radius.circular(16.0),
        ),
        color: themeChange.darkTheme ? Colors.yellow : Colors.lightBlueAccent,
      ),
      child: Row(
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://5.imimg.com/data5/YJ/BO/MY-10973479/mens-designer-casual-shirt-500x500.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: themeChange.darkTheme
                                  ? Colors.blue
                                  : Colors.black),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              FontAwesome5.trash_alt,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Price:',
                        style: TextStyle(
                            color: themeChange.darkTheme
                                ? Colors.blue
                                : Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '450\$',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeChange.darkTheme
                                ? Colors.blue
                                : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Sub Total:',
                        style: TextStyle(
                            color: themeChange.darkTheme
                                ? Colors.blue
                                : Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '450\$',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeChange.darkTheme
                                ? Colors.brown.shade900
                                : Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Ships Free',
                        style: TextStyle(
                          color: themeChange.darkTheme
                              ? Colors.brown.shade900
                              : Theme.of(context).accentColor,
                        ),
                      ),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(4.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                FontAwesome5.minus,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 12,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorsConsts.gradiendFStart,
                              ColorsConsts.gradiendLEnd,
                            ], stops: [
                              0.0,
                              0.7
                            ]),
                          ),
                          child: Text(
                            '154',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(4.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                FontAwesome5.plus,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
