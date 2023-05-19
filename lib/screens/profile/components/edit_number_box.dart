import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class EditBoxPhone extends StatefulWidget {
  const EditBoxPhone({
    Key? key, // Updated
    required this.controller,
    required this.keyboardType,
    this.icon,
    this.label,
    required this.onSaved,
  }) : super(key: key); // Updated

  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? label;
  final Function(String) onSaved;

  @override
  State<EditBoxPhone> createState() => _EditBoxPhoneState();
}

class _EditBoxPhoneState extends State<EditBoxPhone> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              widget.icon,
              size: 20,
              color: kPrimaryColor,
            ),
          ),
          const Text(
            '+91 ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(
            child: Text(
              '| ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: InputDecorator(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              child: TextFormField(
                keyboardType: widget.keyboardType,
                onSaved: (newValue) => widget.onSaved(newValue!),
                onChanged: (newValue) {
                  setState(() {
                    widget.controller.text = newValue;
                  });
                  // Uncomment the lines below if you want to perform any action on changing the value
                  // userProvider.updateUserNumber(number: newValue);
                },
                controller: widget.controller,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: widget.label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
