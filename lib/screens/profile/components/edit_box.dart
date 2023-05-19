import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class EditBox extends StatefulWidget {
  const EditBox({
    Key? key, // Updated
    required this.controller,
    required this.label,
    required this.onSaved,
  }) : super(key: key); // Updated

  final TextEditingController controller;
  final String label;
  final Function(String) onSaved;

  @override
  State<EditBox> createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  final List<String> errors = [];
  bool isEditing = false;
  IconData currentIcon = FontAwesomeIcons.user; // Updated
  String currentText = ''; // Updated

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
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    currentText = userProvider.getUser!.username ?? 'Aman'; // Updated

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
          GestureDetector(
            // Added GestureDetector
            onTap: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FaIcon(
                currentIcon,
                color: kPrimaryColor,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InputDecorator(
              decoration: const InputDecoration(border: InputBorder.none),
              child: TextFormField(
                enabled: isEditing,
                onSaved: (newValue) => widget.onSaved(newValue!),
                onChanged: (newValue) {
                  userProvider.updateUserDetails(
                    displayName: newValue,
                  );
                  setState(() {
                    widget.controller.text = newValue;
                    currentText = newValue; // Updated
                  });
                },
                controller: widget.controller,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: currentText, // Updated
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
