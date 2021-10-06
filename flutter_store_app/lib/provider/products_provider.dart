import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_store_app/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    //   Product(
    //     id: 'Samsung1',
    //     title: 'Samsung Galaxy S9',
    //     description:
    //         'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone w/ 12MP Camera - Midnight Black',
    //     price: 5000,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    //     brand: 'Samsung',
    //     prodCategoryName: 'Phones',
    //     quantity: 65,
    //     isPopular: false),
    // Product(
    //     id: 'Samsung Galaxy A10s',
    //     title: 'Samsung Galaxy A10s',
    //     description:
    //         'Samsung Galaxy A10s A107M - 32GB, 6.2" HD+ Infinity-V Display, 13MP+2MP Dual Rear +8MP Front Cameras, GSM Unlocked Smartphone - Blue.',
    //     price: 600,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
    //     brand: 'Samsung ',
    //     prodCategoryName: 'Phones',
    //     quantity: 1002,
    //     isPopular: false),
    // Product(
    //     id: 'Samsung Galaxy A51',
    //     title: 'Samsung Galaxy A51',
    //     description:
    //         'Samsung Galaxy A51 (128GB, 4GB) 6.5", 48MP Quad Camera, Dual SIM GSM Unlocked A515F/DS- Global 4G LTE International Model - Prism Crush Blue.',
    //     price: 99,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
    //     brand: 'Samsung',
    //     prodCategoryName: 'Phones',
    //     quantity: 6423,
    //     isPopular: true),
    //     Product(
    //     id: 'Huawei P40 Pro',
    //     title: 'Huawei P40 Pro',
    //     description:
    //         'Huawei P40 Pro (5G) ELS-NX9 Dual/Hybrid-SIM 256GB (GSM Only | No CDMA) Factory Unlocked Smartphone (Silver Frost) - International Version',
    //     price: 900,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
    //     brand: 'Xiaomi',
    //     prodCategoryName: 'Phones',
    //     quantity: 3,
    //     isPopular: true),
    // Product(
    //     id: 'iPhone 12 Pro',
    //     title: 'iPhone 12 Pro',
    //     description:
    //         'New Apple iPhone 12 Pro (512GB, Gold) [Locked] + Carrier Subscription',
    //     price: 1100,
    //     imgUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
    //     brand: 'Apple',
    //     prodCategoryName: 'Phones',
    //     quantity: 3,
    //     isPopular: true),
    // Product(
    //     id: 'iPhone 12 Pro Max ',
    //     title: 'iPhone 12 Pro Max ',
    //     description:
    //         'New Apple iPhone 12 Pro Max (128GB, Graphite) [Locked] + Carrier Subscription',
    //     price: 50,
    //     imgUrl:
    //         'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
    //     brand: 'Apple',
    //     prodCategoryName: 'Phones',
    //     quantity: 2654,
    //     isPopular: false),
    // Product(
    //     id: 'Hanes Mens ',
    //     title: 'Long Sleeve Beefy Henley Shirt',
    //     description: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
    //     price: 220,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
    //     brand: 'Addidas',
    //     prodCategoryName: 'Clothes',
    //     quantity: 58466,
    //     isPopular: true),
    // Product(
    //     id: 'Weave Jogger',
    //     title: 'Weave Jogger',
    //     description: 'Champion Mens Reverse Weave Jogger',
    //     price: 5899,
    //     imgUrl:
    //         'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
    //     brand: 'H&M',
    //     prodCategoryName: 'Clothes',
    //     quantity: 84894,
    //     isPopular: false),
    // Product(
    //     id: 'Adeliber Dresses for Womens',
    //     title: 'Adeliber Dresses for Womens',
    //     description:
    //         'Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress',
    //     price: 5099,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
    //     brand: 'H&M',
    //     prodCategoryName: 'Clothes',
    //     quantity: 49847,
    //     isPopular: true),
    // Product(
    //     id: 'Tanjun Sneakers',
    //     title: 'Tanjun Sneakers',
    //     description:
    //         'NIKE Men\'s Tanjun Sneakers, Breathable Textile Uppers and Comfortable Lightweight Cushioning ',
    //     price: 19189,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
    //     brand: 'Nike',
    //     prodCategoryName: 'Shoes',
    //     quantity: 65489,
    //     isPopular: false),
    // Product(
    //     id: 'Training Pant Female',
    //     title: 'Training Pant Female',
    //     description: 'Nike Epic Training Pant Female ',
    //     price: 18999,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/61jvFw72OVL._AC_UX466_.jpg',
    //     brand: 'Nike',
    //     prodCategoryName: 'Clothes',
    //     quantity: 89741,
    //     isPopular: false),
    // Product(
    //     id: 'Trefoil Tee',
    //     title: 'Trefoil Tee',
    //     description: 'Originals Women\'s Trefoil Tee ',
    //     price: 8888,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/51KMhoElQcL._AC_UX466_.jpg',
    //     brand: 'Addidas',
    //     prodCategoryName: 'Clothes',
    //     quantity: 8941,
    //     isPopular: true),
    // Product(
    //     id: 'Long SleeveWoman',
    //     title: 'Long Sleeve woman',
    //     description: ' Boys\' Long Sleeve Cotton Jersey Hooded T-Shirt Tee',
    //     price: 829,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/71lKAfQDUoL._AC_UX466_.jpg',
    //     brand: 'Addidas',
    //     prodCategoryName: 'Clothes',
    //     quantity: 3,
    //     isPopular: false),
    // Product(
    //     id: 'Eye Cream for Wrinkles',
    //     title: 'Eye Cream for Wrinkles',
    //     description:
    //         'Olay Ultimate Eye Cream for Wrinkles, Puffy Eyes + Dark Circles, 0.4 fl oz',
    //     price: 5498,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/61dwB-2X-6L._SL1500_.jpg',
    //     brand: 'No brand',
    //     prodCategoryName: 'Beauty & health',
    //     quantity: 8515,
    //     isPopular: false),
    // Product(
    //     id: 'Mango Body Yogurt',
    //     title: 'Mango Body Yogurt',
    //     description:
    //         'The Body Shop Mango Body Yogurt, 48hr Moisturizer, 100% Vegan, 6.98 Fl.Oz',
    //     price: 8099,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/81w9cll2RmL._SL1500_.jpg',
    //     brand: 'No brand',
    //     prodCategoryName: 'Beauty & health',
    //     quantity: 3,
    //     isPopular: false),
    // Product(
    //     id: 'Food Intensive Skin',
    //     title: 'Food Intensive Skin',
    //     description:
    //         'Weleda Skin Food Intensive Skin Nourishment Body Butter, 5 Fl Oz',
    //     price: 5099,
    //     imgUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/71E6h0kl3ZL._SL1500_.jpg',
    //     brand: 'No Brand',
    //     prodCategoryName: 'Beauty & health',
    //     quantity: 38425,
    //     isPopular: true),
  ];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProductsFromFireStore() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot prodSnapshot) {
          _products = [];
      prodSnapshot.docs.forEach((element) {
        _products.insert(
          0,
          Product(
            id: element.get('productId'),
            description: element.get('description'),
            brand: element.get('brand'),
            imgUrl: element.get('productImage'),
            prodCategoryName: element.get('prodCategoryName'),
            isPopular: true,
            price: int.parse(element.get('price')),
            quantity: int.parse(element.get('quantity')),
            title: element.get('title'),
          ),
        );
      });
      return;
    });
  }

  Product findById(String prodId) {
    return _products.firstWhere((element) => element.id == prodId);
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  List<Product> findByCategory(String categoryName) {
    List _categoryList = _products
        .where((element) => element.prodCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return [..._categoryList];
  }

  List<Product> findByBrand(String brandName) {
    List _brandList = _products
        .where((element) =>
            element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return [..._brandList];
  }

  List<Product> searchQuery(String searchText) {
    List _searchList = _products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return [..._searchList];
  }
}
