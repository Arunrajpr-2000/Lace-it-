// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lace_it/presentation/screens/Home/widget/itemwidget.dart';
import 'widget/Home_header_widget.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeScreenHeaderWidget(searchController: searchController),
        const ItemWidget()
      ],
    );
  }
}
