import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  ListTileWidget({
    Key? key,
    this.IconColor,
    this.TrailingButton,
    this.LeadIcon,
    this.Ontap,
    this.Title,
  }) : super(key: key);

  final IconData? LeadIcon;

  final Color? IconColor;
  final String? Title;
  void Function()? Ontap;
  final Widget? TrailingButton;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(LeadIcon, color: IconColor),
        title: Text(
          '$Title',
          style: TextStyle(color: IconColor),
        ),
        onTap: Ontap,
        trailing: TrailingButton);
  }
}
