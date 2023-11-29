import 'package:flutter/material.dart';
import 'components/profile_body.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kPrimaryColor),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: const ProfileBody(),
      bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}
