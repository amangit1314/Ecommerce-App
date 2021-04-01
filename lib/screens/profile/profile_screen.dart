import 'package:ecommerce_app/components/custom_botton_nav_bar.dart';
import 'package:ecommerce_app/screens/profile/components/components/body.dart';
import 'package:ecommerce_app/utils/enums.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
