import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/components/custom_bottom_nav_bar.dart';
import 'package:tokoto_ecommerce_app/screens/home/components/body.dart';

import '../../utils/enums.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
