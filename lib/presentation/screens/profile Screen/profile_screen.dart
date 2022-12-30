import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/function/profile_fun.dart';
import 'package:lace_it/model/profile_model.dart';
import 'package:lace_it/presentation/screens/profile%20Screen/textcontainer.dart';
import 'package:lace_it/presentation/widgets/headerTile.dart';
import 'package:lace_it/presentation/widgets/textfield_container.dart';

class ScreenProfile extends StatelessWidget {
  ScreenProfile({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        email;
        _nameController.text = user.displayName.toString();
        _phoneController.text = user.phoneNumber.toString();
      },
    );
    return SingleChildScrollView(
      child: StreamBuilder<List<ProfileModel>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(email)
              .collection('userdetails')
              .snapshots()
              .map((snapshot) => snapshot.docs
                  .map((e) => ProfileModel.fromJson(e.data()))
                  .toList()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProfileModel> profilelist = snapshot.data!;
              return Column(
                children: [
                  HeaderTile(
                    Title: const Text(
                      'Profile',
                      style: TextStyle(color: whiteColor, fontSize: 17),
                    ),
                    TrailingButton: [
                      IconButton(
                        onPressed: () {
                          editprofileMethod(context);
                        },
                        icon: const Icon(Icons.edit),
                      )
                    ],
                  ),
                  k20height,
                  k20height,
                  CircleAvatar(
                    backgroundColor: ScaffoldBgcolor,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : const NetworkImage(
                            'https://i.pinimg.com/564x/ef/90/8e/ef908e5a83305dcaaf5106e1e4269997.jpg'),
                    radius: 70,
                  ),
                  k20height,
                  Textcontainer(
                    icondata: Icons.person,
                    text: profilelist[0].username.toString(),
                  ),
                  k20height,
                  Textcontainer(
                    icondata: Icons.email,
                    text: profilelist[0].useremail.toString(),
                  ),
                  k20height,
                  Textcontainer(
                    icondata: Icons.call,
                    text: profilelist[0].userphoneNo.toString(),
                  ),
                  k20height,
                ],
              );
            } else {
              return const Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          }),
    );
  }

  Future<dynamic> editprofileMethod(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            scrollable: true,
            title: const Text(
              'Edit Profile',
              textAlign: TextAlign.center,
              style: TextStyle(color: ScaffoldBgcolor),
            ),
            content: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextfieldContainer(
                      // initialValue: ,
                      Controller: _nameController,
                      hinttext: 'Enter Name',
                      leadingIcon: const Icon(
                        Icons.person,
                        color: whiteColor,
                      ),
                    ),
                    k20height,
                    TextfieldContainer(
                      keyboardType: TextInputType.number,
                      Controller: _phoneController,
                      hinttext: 'Enter Phone number',
                      leadingIcon: const Icon(
                        Icons.call,
                        color: whiteColor,
                      ),
                    ),
                    k20height,
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ScaffoldBgcolor)),
                    onPressed: () {
                      addProfileFun(
                          profileModel: ProfileModel(
                              useremail: email.toString(),
                              username: _nameController.text,
                              userphoneNo: _phoneController.text));
                      Navigator.of(context).pop();
                    },
                    child: const Text("Submit")),
              ),
            ],
          );
        });
  }
}
