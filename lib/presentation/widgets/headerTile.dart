import 'package:flutter/material.dart';

class HeaderTile extends StatelessWidget {
  HeaderTile(
      {Key? key, this.Title, this.TrailingButton, this.leadingIconbutton})
      : super(key: key);

  IconButton? leadingIconbutton;
  Text? Title;
  List<Widget>? TrailingButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: leadingIconbutton,
      title: Title,
      actions: TrailingButton,
    );
  }
}
