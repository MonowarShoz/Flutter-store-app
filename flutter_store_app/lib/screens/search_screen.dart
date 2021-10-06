import 'package:flutter/material.dart';
import 'package:flutter_store_app/consts/app_colors.dart';
import 'package:flutter_store_app/models/product.dart';
import 'package:flutter_store_app/provider/products_provider.dart';
import 'package:flutter_store_app/widgets/product_feed.dart';
import 'package:flutter_store_app/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchTextEditingController;
  final FocusNode _node = FocusNode();
  List<Product> _searchList = [];
  @override
  void initState() {
    super.initState();
    _searchTextEditingController = TextEditingController();
    _searchTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _node.dispose();
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context);
    final prodList = prodData.products;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: SearchWidget(
              stackPaddingTop: 175,
              titlePaddingTop: 50,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsConsts.title,
                        fontSize: 24,
                      ),
                    )
                  ],
                ),
              ),
              subTitle: Text('Searching'),
              leading: Icon(Icons.search),
              action: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              stackChild: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchTextEditingController,
                  maxLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                      onPressed: _searchTextEditingController.text.isEmpty
                          ? null
                          : () {
                              _searchTextEditingController.clear();
                              _node.unfocus();
                            },
                      icon: Icon(
                        Icons.delete,
                        color: _searchTextEditingController.text.isNotEmpty
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    _searchTextEditingController.text.toLowerCase();
                    setState(() {
                      _searchList = prodData.searchQuery(value);
                    });
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _searchTextEditingController.text.isNotEmpty &&
                    _searchList.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.search,
                        size: 60,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'No results found',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                : GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 240 / 420,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                      _searchTextEditingController.text.isEmpty
                          ? prodList.length
                          : _searchList.length,
                      (index) => ChangeNotifierProvider.value(
                        value: _searchTextEditingController.text.isEmpty
                            ? prodList[index]
                            : _searchList[index],
                        child: ProductFeed(),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
