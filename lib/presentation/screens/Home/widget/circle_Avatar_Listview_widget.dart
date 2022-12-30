import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({Key? key, this.BrandName, this.Ontap})
      : super(key: key);

  final String? BrandName;
  final Function()? Ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Ontap,
      child: CircleAvatar(
        backgroundColor: const Color(0xff393A3F),
        radius: 35.r,
        child: Text(
          BrandName.toString(),
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: oswald,
              color: whiteColor,
              overflow: TextOverflow.visible,
              fontSize: 14),
        ),
      ),
    );
  }
}
