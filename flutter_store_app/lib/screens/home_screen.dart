import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/navigation_rail/brand_nav_rail.dart';
import 'package:flutter_store_app/provider/products_provider.dart';
import 'package:flutter_store_app/screens/feed_screen.dart';
import 'package:flutter_store_app/widgets/back_layer_widget.dart';
import 'package:flutter_store_app/widgets/category_widget.dart';
import 'package:flutter_store_app/widgets/popular_prod_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeIndex = 0;
  final _imageList = [
    'assets/images/carousel2.jpeg',
    'assets/images/onlinesh.png',
    'assets/images/smartph.jpg',
  ];
  final _brandImage = [
    'https://st2.depositphotos.com/1102480/6675/i/600/depositphotos_66757781-stock-photo-apple-logotype-printed-on-paper.jpg',
    'https://s3.amazonaws.com/cdn.designcrowd.com/blog/100-Famous-Brand%20Logos-From-The-Most-Valuable-Companies-of-2020/samsung-logo.png',
    'https://1000logos.net/wp-content/uploads/2021/04/HyperX-logo-500x286.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Xiaomi_logo_%282021-%29.svg/1200px-Xiaomi_logo_%282021-%29.svg.png',
  ];
  @override
  void initState() {
    super.initState();
    getData();
  }

  String? _imgUrl;
  Future<void> getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    final DocumentSnapshot? userDoc = (user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get());
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        _imgUrl = userDoc.get('imageUrl');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context);
    prodData.fetchProductsFromFireStore();
    final popularProd = prodData.popularProducts;

    return Scaffold(
      body: Center(
        child: BackdropScaffold(
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          headerHeight: MediaQuery.of(context).size.height * 0.25,
          appBar: BackdropAppBar(
            title: Text("Store"),
            leading: BackdropToggleButton(
              color: Colors.purple,
              icon: AnimatedIcons.home_menu,
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                iconSize: 25,
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(_imgUrl == null
                      ? 'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'
                      : _imgUrl!),
                ),
              ),
            ],
          ),
          backLayer: BackLayerMenuScreen(
            img: _imgUrl == null
                ? 'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'
                : _imgUrl!,
          ),
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
                          itemCount: 4,
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
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                BrandNavRailScreen.routeName,
                                arguments: {
                                  7,
                                },
                              );
                            },
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
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  FeedScreen.routeName,
                                  arguments: 'popular');
                            },
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
                          itemCount: popularProd.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ChangeNotifierProvider.value(
                              value: popularProd[index],
                              child: PopularProducts(),
                            );
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
      child: Image.asset(
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
