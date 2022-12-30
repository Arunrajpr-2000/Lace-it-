// import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';

class TextfieldContainer extends StatelessWidget {
  TextfieldContainer(
      {Key? key,
      this.Controller,
      this.hinttext,
      this.TrailingIcon,
      this.validator,
      this.initialValue,
      this.onTap,
      this.errorText,
      this.keyboardType,
      this.leadingIcon,
      this.onChanged})
      : super(key: key);

  TextEditingController? Controller = TextEditingController();
  String? hinttext, errorText;
  Icon? leadingIcon;
  String? initialValue;
  TextInputType? keyboardType;
  IconButton? TrailingIcon;
  void Function()? onTap;

  // void OnChange;
  void Function(String)? onChanged;

  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.sp,
      height: 55.sp,
      decoration: BoxDecoration(
          color: const Color(0xff1F222B),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: onTap,
        leading: leadingIcon,
        title: TextFormField(
          onTap: onTap,
          initialValue: initialValue,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          style: const TextStyle(color: whiteColor),
          cursorColor: whiteColor,
          controller: Controller,
          decoration: InputDecoration(
            errorText: errorText,
            border: InputBorder.none,
            hintText: hinttext,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
        ),
        trailing: TrailingIcon,
      ),
    );
  }
}
