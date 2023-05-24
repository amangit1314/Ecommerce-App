import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class EditBoxPhone extends StatefulWidget {
  const EditBoxPhone({
    Key? key, // Updated
    required this.passwordController,
    required this.keyboardType,
    this.icon,
    this.label,
    required this.onSaved,
  }) : super(key: key); // Updated

  final TextEditingController passwordController;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? label;
  final Function(String) onSaved;

  @override
  State<EditBoxPhone> createState() => _EditBoxPhoneState();
}

class _EditBoxPhoneState extends State<EditBoxPhone> {
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onSaved: (newValue) => widget.passwordController.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
