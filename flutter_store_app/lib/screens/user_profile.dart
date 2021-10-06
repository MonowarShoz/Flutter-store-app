import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/provider/dark_theme.dart';
import 'package:flutter_store_app/screens/cart_screen.dart';
import 'package:flutter_store_app/screens/wishlist_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late ScrollController _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _name;
  String _email = '';
  String? _joinedAt = '';
  int? _phoneNumber;
  String? _imgUrl ;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });

    getDataFromFirebase();
  }

  Future<void> getDataFromFirebase() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot? userDocs = (user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get());

    if (userDocs == null) {
      return;
    } else {
      setState(() {
        _name = userDocs.get('name');
        _email = userDocs.get('email');
        _phoneNumber = userDocs.get('phoneNumber');
        _imgUrl = userDocs.get('imageUrl');
        _joinedAt = userDocs.get('joinedAt');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorsConsts.starterColor,
                          ColorsConsts.endColor,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top <= 110.0 ? 1.0 : 0.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 12),
                            Container(
                              height: kToolbarHeight / 1.8,
                              width: kToolbarHeight / 1.8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(_imgUrl == null
                                      ? 'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'
                                      : _imgUrl!),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              _name == null ? 'Guest' : _name!,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      background: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          _imgUrl == null
                              ? 'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'
                              : _imgUrl!,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: userTextTile('User Bag'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(WishListScreen.routeName);
                        },
                        splashColor: Colors.red,
                        child: ListTile(
                          title: Text('Wishlist'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(FontAwesome5.heart),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      title: Text('Cart'),
                      trailing: Icon(Icons.chevron_right_rounded),
                      leading: Icon(FontAwesome5.cart_plus),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: userTextTile('User Information'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('email', _email, 0, context),
                    userListTile('phone', _phoneNumber.toString(), 1, context),
                    userListTile('Shipping address', 'subtitle', 2, context),
                    userListTile(
                        'Joined Date', _joinedAt.toString(), 3, context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTextTile('User Settings'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: themeChange.darkTheme,
                      onChanged: (value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      },
                      leading: Icon(Icons.mode_night_rounded),
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.indigo,
                      title: Text('Default Switch'),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: ListTile(
                          title: Text('Log Out'),
                          leading: Icon(Icons.exit_to_app_rounded),
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6.0),
                                          child: Image.network(
                                            'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Sign out'),
                                        ),
                                      ],
                                    ),
                                    content: Text('Do you wanna Sign out?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await _auth.signOut().then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                        },
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    final double defaultTopMargin = 200.0 - 30.0;
    final double scaleStart = 160.0;
    final double scaleEnd = scaleStart / 2;
    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offSet = _scrollController.offset;
      top -= offSet;
      if (offSet < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offSet < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offSet) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  Widget userTextTile(String? title) {
    return Text(
      title!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded,
  ];

  Widget userListTile(
      String? title, String subtitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title!),
          subtitle: Text(subtitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
  }
}
