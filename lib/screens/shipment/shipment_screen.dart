import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/utils/constatns.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/enums.dart';

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
            //? Map container
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * .45,
            ),
            //* Rest Ui
            Container(
              height: MediaQuery.of(context).size.height * .39,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Flexible(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 15),
                            blurRadius: 27,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: const AssetImage(
                            'assets/images/shoes2.png',
                          ),
                        ),
                        title: const Text('Nike Air Max 270'),
                        subtitle: const Text(
                          'Size: 7.5',
                          style: TextStyle(
                            color: kSecondaryColor,
                          ),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              size: 14,
                              FontAwesomeIcons.phone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Flexible(
                    //   child: CustomScrollView(slivers: []),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.shipment),
    );
  }
}
