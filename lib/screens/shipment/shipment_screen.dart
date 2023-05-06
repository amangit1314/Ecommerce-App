import 'package:flutter/material.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../home/components/home_header.dart';

class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen({super.key});

  @override
  State<ShipmentScreen> createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
          ],
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.shipment),
    );
  }
}
