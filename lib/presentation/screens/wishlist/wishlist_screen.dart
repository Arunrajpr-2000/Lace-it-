import 'package:flutter/material.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/presentation/screens/search/search_screen.dart';
import 'package:lace_it/presentation/screens/wishlist/widgets/wishlist_item.dart';
import 'package:lace_it/presentation/widgets/headerTile.dart';

class ScreenWishlist extends StatelessWidget {
  const ScreenWishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeaderTile(
            Title: const Text(
              'Wishlist',
              style: TextStyle(color: whiteColor),
            ),
            TrailingButton: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ScreenSearch()));
                },
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ),
              ),
            ]),
        k10height,
        const WishlistItem()
      ],
    );
  }
}
