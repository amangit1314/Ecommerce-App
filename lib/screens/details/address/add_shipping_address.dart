import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/address.dart';
import 'package:soni_store_app/providers/auth_provider.dart';
import 'package:soni_store_app/utils/constants.dart';
import 'package:uuid/uuid.dart';

import '../../../components/default_button.dart';
import '../../../providers/address_provider.dart';

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({Key? key}) : super(key: key);

  @override
  State<AddShippingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addressTypeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    addressTypeController.dispose();
    phoneController.dispose();
    pinCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Add new Address',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: DefaultButton(
                text: 'Pick From Geolocator',
                txtColor: Colors.white,
                press: () {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text('OR'),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 7.5),
                    child: buildTextFormField(
                      controller: addressTypeController,
                      hintText: 'Enter address type',
                      icon: FontAwesomeIcons.houseCircleCheck,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 7.5),
                    child: buildTextFormField(
                      controller: addressController,
                      hintText: 'Enter your address',
                      icon: FontAwesomeIcons.addressBook,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 7.5),
                    child: buildTextFormField(
                      controller: phoneController,
                      hintText: 'Enter your phone number',
                      icon: FontAwesomeIcons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 7.5),
                    child: buildTextFormField(
                      controller: pinCodeController,
                      hintText: 'Enter your pin code',
                      icon: FontAwesomeIcons.locationPin,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: DefaultButton(
                text: 'Add Address',
                txtColor: Colors.white,
                press: () {
                  final addressProvider = context.read<AddressProvider>();
                  final authProvider = context.read<AuthProvider>();

                  String generateAddressId() {
                    const uuid = Uuid();
                    return uuid.v4();
                  }

                  final String generatedAddressId = generateAddressId();

                  final address = Address(
                    uid: authProvider.user.uid,
                    addressId: generatedAddressId,
                    address: addressController.text,
                    addressType: addressTypeController.text,
                    phone: phoneController.text,
                    pincode: pinCodeController.text,
                  );

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (authProvider.user.uid != '' &&
                        authProvider.user.uid.isNotEmpty) {
                      addressProvider
                          .addAddress(
                        address,
                        authProvider.user.uid,
                      )
                          .then((_) {
                        const GetSnackBar(
                          title: 'Address Added ✔',
                          message: 'Address Successfully Added ✔✨',
                          backgroundColor: Colors.greenAccent,
                        );
                        log('Address Added Successfully');
                        Navigator.pop(context);
                      }).catchError((error) {
                        GetSnackBar(
                          title: 'Error Caught ⚠',
                          message: error.toString(),
                          backgroundColor: Colors.red,
                        );
                      });
                    }

                    log('User Id -> ${authProvider.user.uid}');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 12),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: Icon(
          icon,
          size: 16,
          color: kPrimaryColor,
        ),
        hintStyle: const TextStyle(fontSize: 12),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
