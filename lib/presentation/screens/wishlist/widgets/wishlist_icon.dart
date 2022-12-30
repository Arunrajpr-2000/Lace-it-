import 'package:flutter/material.dart';

class wishlistIcon extends StatelessWidget {
  wishlistIcon({Key? key, required this.iconData, required this.onTap})
      : super(key: key);
  IconData iconData;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        iconData,
        color: Colors.red,
      ),
    );
  }
}
