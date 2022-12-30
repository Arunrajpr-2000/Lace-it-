import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    Key? key,
    this.OnPressAdd,
    this.OnPressSub,
    this.Quantity,
  }) : super(key: key);

  final Function()? OnPressAdd;
  final Function()? OnPressSub;
  final String? Quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
          color: const Color(0xff1F222B),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: OnPressSub,
              icon: const Icon(
                Icons.remove,
                color: whiteColor,
              )),
          Text(
            "$Quantity",
            style: const TextStyle(color: whiteColor),
          ),
          IconButton(
              onPressed: OnPressAdd,
              icon: const Icon(
                Icons.add,
                color: whiteColor,
              )),
        ],
      ),
    );
  }
}
