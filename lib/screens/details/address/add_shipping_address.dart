import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/address.dart';

import '../../../components/default_button.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/user_provider_try.dart';
import '../../../utils/size_config.dart';

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({super.key});

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
    final address = context.watch<UserProviderTry>().user;
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
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Column(
              children: [
                Text(address.toString()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('OR'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 25, right: 15, left: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: TextFormField(
                          controller: addressTypeController,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12)),
                          decoration: InputDecoration(
                            hintText: 'Enter address type',
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              FontAwesomeIcons.houseCircleCheck,
                              size: 16,
                            ),
                            hintStyle: TextStyle(
                                fontSize: getProportionateScreenWidth(12)),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 15, right: 15, left: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: TextFormField(
                          controller: addressController,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12)),
                          decoration: InputDecoration(
                            hintText: 'Enter your address',
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              FontAwesomeIcons.addressBook,
                              size: 16,
                            ),
                            hintStyle: TextStyle(
                                fontSize: getProportionateScreenWidth(12)),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 15, right: 15, left: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: TextFormField(
                          controller: phoneController,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12)),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter your phone number',
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              FontAwesomeIcons.phone,
                              size: 16,
                            ),
                            hintStyle: TextStyle(
                                fontSize: getProportionateScreenWidth(12)),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 15, right: 15, left: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: TextFormField(
                          controller: pinCodeController,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter your pin code',
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              FontAwesomeIcons.locationPin,
                              size: 16,
                            ),
                            hintStyle: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
              child: DefaultButton(
                text: 'Add Address',
                txtColor: Colors.white,
                press: () {
                  final userProvider = context.read<UserProvider>();
                  final userProviderTry = context.read<UserProviderTry>();

                  final address = Address(
                    address: addressController.text,
                    addressType: addressTypeController.text,
                    phone: phoneController.text,
                    pincode: pinCodeController.text,
                  );

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (userProviderTry.uid != '') {
                      // userProvider
                      //     .addAddress(userProvider.uid, address)
                      //     .then((_) {
                      //   Navigator.pop(context);
                      // }).catchError((error) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(error.toString()),
                      //       backgroundColor: Colors.red,
                      //     ),
                      //   );
                      // });

                      // log(userProvider.uid);
                      // userProviderTry.setAddress(address, userProvider.uid);

                      log(userProviderTry.uid);
                      userProviderTry.setAddress(address, userProviderTry.uid);
                    }

                    log(userProvider.uid);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
