import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lace_it/model/cart_model.dart';

final email = FirebaseAuth.instance.currentUser!.email;

Future addtoCart({
  required CartModel CartModel,
}) async {
  final userdoc = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('cart')
      .doc(CartModel.id);

  final json = CartModel.toJson();
  log('cart calleddddddddd');
  await userdoc.set(json);
  log('Addded to cart');
}

removeFromCart({required String id}) {
  final docProduct = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('cart')
      .doc(id);
  docProduct.delete();
}
