import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .whenComplete(() async {
        final email = FirebaseAuth.instance.currentUser!.email;
        final phonenumber = FirebaseAuth.instance.currentUser!.phoneNumber;
        final name = FirebaseAuth.instance.currentUser!.displayName;
        final profileimage = FirebaseAuth.instance.currentUser!.photoURL;

        // final passwords = FirebaseAuth.instance.currentUser!;

        log(email.toString());

        final docUser =
            FirebaseFirestore.instance.collection('users').doc(email);
        List<String> Cart = [];
        Map<String, dynamic> map = {
          'name': name,
          'email': email,
          'phonenum': phonenumber,
          'profileimage': profileimage,
          'password': 'google signin'
        };
        await docUser.set(map).whenComplete(() async {
          final docUser = FirebaseFirestore.instance
              .collection('users')
              .doc(email)
              .collection('userdetails')
              .doc('userdetails');
          List<String> Cart = [];
          Map<String, dynamic> map = {
            'email': email,
            'name': name,
            'phonenum': '',
          };
          await docUser.set(map);
          log('new user created n added to databse');
        });

        // inside docEmail creating a collection

        // CollectionReference collectionReference = FirebaseFirestore.instance
        //     .collection("users")
        //     .doc(email)
        //     .collection('Account');

        // Map<String, dynamic> categoryfield = {
        //   "name": email,
        // };

        // collectionReference.add(categoryfield).whenComplete(() {
        //   log('collection----->  $email Created');
        // });

        log('new user created n added to databse');
      });
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
