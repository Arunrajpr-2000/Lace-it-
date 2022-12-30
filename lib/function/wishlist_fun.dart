import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lace_it/model/product_model.dart';

final email = FirebaseAuth.instance.currentUser!.email;

Future addToFav({
  required Product product,
}) async {
  final userdoc = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('wishlist')
      .doc(product.id);

  final json = product.toJson();

  await userdoc.set(json);
  log('Addded to wishlist');
}

removeFromFav({required String id}) {
  final docProduct = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('wishlist')
      .doc(id);
  docProduct.delete();
}
