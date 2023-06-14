import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/address_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class AddressTile extends StatelessWidget {
  final bool isSelected;
  final String addressType;
  final String address;
  final String addressId;
  final String pincode;
  final String number;
  final String uid;

  const AddressTile({
    Key? key,
    required this.isSelected,
    required this.addressType,
    required this.address,
    required this.pincode,
    required this.number,
    required this.uid,
    required this.addressId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressProvider = context.read<AddressProvider>();
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
      width: MediaQuery.of(context).size.width * .91,
      margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? kPrimaryColor : Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
              Text(
                '$address, $pincode',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor.withOpacity(.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              addressProvider.updateSelectedAddress(addressId, uid);
            },
            icon: isSelected
                ? const Icon(Icons.check_circle, color: Colors.orangeAccent)
                : const Icon(Icons.circle_outlined),
          ),
        ],
      ),
    );
  }
}
