import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lace_it/model/order_product_model.dart';

final email = FirebaseAuth.instance.currentUser!.email;

Future addorder({
  required OrderedProduct orderModel,
}) async {
  final userdoc = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('order')
      .doc(orderModel.id);

  final json = orderModel.toJson();
  log('cart calleddddddddd');
  await userdoc.set(json);
  log('Addded to cart');
}

removeFromorder({required String id}) {
  final docProduct = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('order')
      .doc(id);
  docProduct.delete();
}
