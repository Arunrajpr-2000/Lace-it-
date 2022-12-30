import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/presentation/screens/Home/widget/inside_category.dart';
import 'package:lace_it/presentation/screens/profile%20Screen/textcontainer.dart';
import 'package:lace_it/presentation/screens/search/search_screen.dart';
import 'package:lace_it/presentation/screens/settings/setting_screen.dart';
import 'package:lace_it/presentation/widgets/headerTile.dart';

import '../../../../core/constants/constants.dart';
import 'circle_Avatar_Listview_widget.dart';

class HomeScreenHeaderWidget extends StatelessWidget {
  const HomeScreenHeaderWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderTile(
            Title: const Text(
              'Home',
              style: TextStyle(
                color: whiteColor,
              ),
            ),
            TrailingButton: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingScreen()));
                },
                icon: const Icon(
                  Icons.settings_suggest,
                  color: whiteColor,
                ),
              )
            ]),
        k20height,
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            width: double.infinity,
            child: Textcontainer(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScreenSearch()));
              },
              icons: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              text: 'Looking For Shoes',
              textcolor: Colors.grey,
            ),
          ),
        ),
        k20height,
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Shoes',
                style: TextStyle(fontFamily: oswald, color: whiteColor),
              ),
              Text(
                'See All',
                style: TextStyle(fontFamily: oswald, color: whiteColor),
              ),
            ],
          ),
        ),
        k10height,
        SizedBox(
          height: 100.h,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => k10width,
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      String id = snapshot.data!.docs[index].id;
                      log("ID $id");
                      if (id == documentSnapshot['name']) {
                        return CircleAvatarWidget(
                          Ontap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InSideCategory(
                                brandName: documentSnapshot['name']),
                          )),
                          BrandName: documentSnapshot['name'],
                        );
                      } else {
                        return const Text('');
                      }
                    },
                  );
                } else {
                  return const Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }
}
