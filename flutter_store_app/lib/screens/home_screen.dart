import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/navigation_rail/brand_nav_rail.dart';
import 'package:flutter_store_app/widgets/back_layer_widget.dart';
import 'package:flutter_store_app/widgets/category_widget.dart';
import 'package:flutter_store_app/widgets/popular_prod_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeIndex = 0;
  final _imageList = [
    'https://images.unsplash.com/photo-1473187983305-f615310e7daa?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'
        'https://image.shutterstock.com/shutterstock/photos/1896887080/display_1500/stock-photo--d-rendering-of-smartphone-and-online-shopping-1896887080.jpg',
    'https://image.shutterstock.com/image-illustration/3d-rendering-minimal-search-bar-600w-1899017110.jpg',
    'https://images.unsplash.com/photo-1607082349566-187342175e2f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
  ];
  final _brandImage = [
    'https://s3.amazonaws.com/cdn.designcrowd.com/blog/100-Famous-Brand%20Logos-From-The-Most-Valuable-Companies-of-2020/coca-cola-logo.png',
    'https://s3.amazonaws.com/cdn.designcrowd.com/blog/100-Famous-Brand%20Logos-From-The-Most-Valuable-Companies-of-2020/samsung-logo.png',
    'https://s3.amazonaws.com/cdn.designcrowd.com/blog/100-Famous-Brand%20Logos-From-The-Most-Valuable-Companies-of-2020/gucci-logo.png',
    'https://s3.amazonaws.com/cdn.designcrowd.com/blog/100-Famous-Brand%20Logos-From-The-Most-Valuable-Companies-of-2020/loreal-logo.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BackdropScaffold(
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          headerHeight: MediaQuery.of(context).size.height * 0.25,
          appBar: BackdropAppBar(
            title: Text("Backdrop Example"),
            leading: BackdropToggleButton(
              color: Colors.black,
              icon: AnimatedIcons.home_menu,
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                iconSize: 25,
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                ),
              ),
            ],
          ),
          backLayer: BackLayerMenuScreen(),
          frontLayer: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: CarouselSlider.builder(
                    itemCount: _imageList.length,
                    options: CarouselOptions(
                      height: 200,
                      initialPage: 0,
                      viewportFraction: 0.9,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 300),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _activeIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      final img = _imageList[index];
                      return buildCarouselImage(img, index);
                    },
                  ),
                ),
                SizedBox(height: 4),
                buildDotIndicator(),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctx, int index) {
                            return CategoryWidget(
                              index: index,
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Popular Brands',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text('View all..'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Swiper(
                        itemCount: _brandImage.length,
                        autoplay: true,
                        viewportFraction: 0.8,
                        scale: 0.86,
                        onTap: (index) {
                          Navigator.of(context).pushNamed(
                            BrandNavRailScreen.routeName,
                            arguments: {
                              index,
                            },
                          );
                        },
                        itemBuilder: (BuildContext ctx, int index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              _brandImage[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Popular Products',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text('View all..'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 285,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return PopularProducts();
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCarouselImage(String img, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey,
      child: Image.network(
        img,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildDotIndicator() => AnimatedSmoothIndicator(
        activeIndex: _activeIndex,
        count: _imageList.length,
        effect: JumpingDotEffect(
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
