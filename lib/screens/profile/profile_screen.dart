import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/profile/components/components/body.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/enums.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Body(),
      bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}
