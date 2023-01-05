import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lace_it/model/product_model.dart';

class SearchFuction {
  static Future<List<Product>> searchProduct(
      {required String search_input}) async {
    final allProducts = await fetchAllProduct();
    List<Product> filteredList = [];
    for (Product temp in allProducts) {
      if (temp.name
          .toString()
          .toUpperCase()
          .contains(search_input.toUpperCase())) {
        filteredList.add(temp);
      }
    }
    return filteredList;
  }

  static Future<List<Product>> fetchAllProduct() async {
    final searchproduct = FirebaseFirestore.instance
        .collection('all')
        // .doc('popular')
        // .collection('popular')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
    final firstsearch = await searchproduct.first;
    return firstsearch;
  }
}
