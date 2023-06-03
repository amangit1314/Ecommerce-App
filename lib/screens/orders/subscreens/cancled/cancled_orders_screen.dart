import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/utils/constants.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../providers/providers.dart';

class CancledOrders extends StatelessWidget {
  final void Function()? onTap;
  const CancledOrders({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: getProportionateScreenHeight(60),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where('orderStatus', isEqualTo: 'Cancled')
                .where('uid', isEqualTo: authProvider.user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              int orderCount = snapshot.data!.docs.length;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.circleXmark,
                        size: 12,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: getProportionateScreenWidth(10)),
                      const Text(
                        "Cancled Orders",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 2,
                          bottom: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          orderCount.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
