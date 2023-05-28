import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constatns.dart';
import '../../../utils/size_config.dart';

class AddressTile extends StatelessWidget {
  final bool isSelected;
  final String addressType;
  final String address;
  final String pincode;
  final String number;
  const AddressTile({
    super.key,
    this.isSelected = false,
    this.addressType = 'My Address',
    this.address = 'Gudri Bajar, Mochiwara Churu',
    this.pincode = '331001',
    this.number = '+91 9649477393',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        border: Border.all(
          color: isSelected ? kPrimaryColor : Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 18,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.addressCard,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(15)),
              Text(
                addressType,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Gudri Bajar, Mochiwara, Churu',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '+91 9649477393',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
