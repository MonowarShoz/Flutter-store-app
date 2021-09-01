import 'package:flutter/material.dart';
import 'package:flutter_store_app/navigation_rail/brand_rail_screen.dart';

class BrandNavRailScreen extends StatefulWidget {
  const BrandNavRailScreen({Key? key}) : super(key: key);
  static const routeName = '/brands_navigation_rail';

  @override
  _BrandNavRailScreenState createState() => _BrandNavRailScreenState();
}

class _BrandNavRailScreenState extends State<BrandNavRailScreen> {
  int _selectedIndex = 0;
  final padding = 8.0;
  String? routeArgs;
  String? brand;

  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs!.substring(1, 2),
    );
    if (_selectedIndex == 0) {
      setState(() {
        brand = 'Adidas';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'Apple';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'Dell';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'Xiaomi';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'Hp';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'Nike';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'Samsung';
      });
    }
    if (_selectedIndex == 7) {
      setState(() {
        brand = 'All';
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      selectedIndex: _selectedIndex,
                      minWidth: 56.0,
                      groupAlignment: 1.0,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              brand = 'Addidas';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brand = 'Apple';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brand = 'Dell';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              brand = 'Xiaomi';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              brand = 'Hp';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              brand = 'Nike';
                            });
                          }
                          if (_selectedIndex == 6) {
                            setState(() {
                              brand = 'Samsung';
                            });
                          }
                          if (_selectedIndex == 7) {
                            setState(() {
                              brand = 'All';
                            });
                          }
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage(
                                'assets/images/Beauty.jpg',
                                 ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination('Addidas', padding),
                        buildRotatedTextRailDestination("Apple", padding),
                        buildRotatedTextRailDestination("Dell", padding),
                        buildRotatedTextRailDestination("Xiaomi", padding),
                        buildRotatedTextRailDestination("hp", padding),
                        buildRotatedTextRailDestination("Nike", padding),
                        buildRotatedTextRailDestination("Samsung", padding),
                        buildRotatedTextRailDestination("All", padding),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Content(brand: brand,),
        ],
      ),
    );
  }

  NavigationRailDestination buildRotatedTextRailDestination(
      String text, double padding) {
    return NavigationRailDestination(
      icon: SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(text),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
 
  final String? brand;
  const Content({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  BrandRailScreen(),
            )),
      ),
    );
  }
}
