import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lace_it/function/cart_fun.dart';
import 'package:lace_it/model/profile_model.dart';

Future addProfileFun({
  required ProfileModel profileModel,
}) async {
  final userdoc = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('userdetails')
      .doc('userdetails');

  final json = profileModel.toJson();
  log('cart calleddddddddd');
  await userdoc.set(json);
  log('Addded to cart');
}
