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
    required this.isSelected,
    required this.addressType,
    required this.address,
    required this.pincode,
    required this.number,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '$address,',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                pincode,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            number,
            style: const TextStyle(
              fontSize: 12,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
