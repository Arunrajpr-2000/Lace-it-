import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lace_it/model/product_model.dart';

class SearchFuction {
  static Future<List<Product>> searchProduct(
      {required String Search_text}) async {
    final allProducts = await fetchAllProduct();
    List<Product> filteredList = [];
    for (Product temp in allProducts) {
      if (temp.name
          .toString()
          .toUpperCase()
          .contains(Search_text.toUpperCase())) {
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
    final temp = await searchproduct.first;
    return temp;
  }
}
