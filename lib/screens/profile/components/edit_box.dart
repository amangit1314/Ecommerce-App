import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class EditBox extends StatelessWidget {
  EditBox(
      {Key? key,
      required this.controller,
      required this.onChanged,
      required this.addError})
      : super(key: key);

  final TextEditingController controller;
  final void addError;
  final Function(String) onChanged;
  final List<String> errors = [];
  bool isEditing = false;
  IconData currentIcon = FontAwesomeIcons.user;
  String currentText = '';

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.getUser != null) {
      currentText = userProvider.getUser!.username ?? 'Aman';
    }
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => controller.text = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          addError;
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: userProvider.getUser?.email,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const FaIcon(
          FontAwesomeIcons.circleUser,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
