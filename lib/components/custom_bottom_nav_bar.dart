import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:soni_store_app/screens/orders/orders_screen.dart';
import 'package:soni_store_app/screens/products/products_search_screen.dart';

import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../utils/constatns.dart';
import '../utils/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;
  final Color inActiveIconColor = const Color(0xFFB6B6B6);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                colorFilter: ColorFilter.mode(
                    MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    BlendMode.srcIn),
              ),
              onPressed: () => Get.to(() => const HomeScreen()),
            ),
            IconButton(
              icon: Icon(
                Icons.category_outlined,
                color: MenuState.shipment == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () => Get.to(() => const ProductSearchPage()),
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.moneyCheck,
                color: MenuState.wallet == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () => Get.to(() => const RecentsScreen()),
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.circleUser,
                color: MenuState.profile == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () => Get.to(() => const ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
