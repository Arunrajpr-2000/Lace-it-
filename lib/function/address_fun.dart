import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lace_it/model/address_model.dart';
import 'package:lace_it/function/cart_fun.dart';

Future addAddressFun({
  required AddressModel addressModel,
}) async {
  final userdoc = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('Address')
      .doc(addressModel.id);

  final json = addressModel.toJson();
  log('cart calleddddddddd');
  await userdoc.set(json);
  log('Addded to cart');
}
