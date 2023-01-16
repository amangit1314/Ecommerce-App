import 'package:flutter/material.dart';
import 'package:soni_store_app/components/custom_bottom_nav_bar.dart';
import 'package:soni_store_app/screens/home/components/body.dart';

import '../../utils/enums.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
