import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class EditBoxEmail extends StatefulWidget {
  const EditBoxEmail({
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
  State<EditBoxEmail> createState() => _EditBoxEmailState();
}

class _EditBoxEmailState extends State<EditBoxEmail> {
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
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
            child: FaIcon(
              widget.icon,
              color: kPrimaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
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
                    if (newValue.isNotEmpty) {
                      widget.controller.text = newValue;
                    }
                  });

                  userProvider.updateUserEmail(email: widget.controller.text);
                },
                controller: widget.controller,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: widget.label, // Use 'labelText' instead of 'label'
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
