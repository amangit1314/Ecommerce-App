// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/providers/address_provider.dart';
import 'package:soni_store_app/providers/auth_provider.dart';
import 'package:soni_store_app/screens/details/address/add_shipping_address.dart';
import 'package:soni_store_app/screens/details/address/address_tile.dart';
import 'package:soni_store_app/utils/constants.dart';

class ShippingAddressesListScreen extends StatefulWidget {
  const ShippingAddressesListScreen({Key? key}) : super(key: key);

  @override
  State<ShippingAddressesListScreen> createState() =>
      _ShippingAddressesListScreenState();
}

class _ShippingAddressesListScreenState
    extends State<ShippingAddressesListScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Shipping Address',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          // Add address button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddShippingAddress(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kPrimaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.locationCrosshairs,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Add Location',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Addresses List
          Expanded(
            child: FutureBuilder<List<models.Address>>(
              future: addressProvider.fetchAddresses(authProvider.user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  log('----------------------------------');
                  log(snapshot.error.toString());
                  log('----------------------------------');
                  return const Center(child: Text('Something went wrong'));
                }

                final List<models.Address> addressesList = snapshot.data ?? [];

                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: addressesList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) => Row(
                    children: [
                      AddressTile(
                        uid: authProvider.user.uid,
                        addressId: addressesList[index].addressId,
                        isSelected: addressesList[index].addressId ==
                            addressProvider.selectedAddress.addressId,
                        pincode: addressesList[index].pincode,
                        address: addressesList[index].address,
                        addressType: addressesList[index].addressType,
                        number: addressesList[index].phone,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
