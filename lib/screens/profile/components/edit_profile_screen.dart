import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/user_provider.dart';
import 'package:soni_store_app/screens/profile/components/profile_pic.dart';
import 'package:soni_store_app/utils/constants.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../providers/profile_controller_provider.dart';
import 'edit_box.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileControllerProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ProfilePic(),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    profileProvider.showUsernameDialogAlert(
                        context,
                        FirebaseAuth.instance.currentUser!.email!
                            .substring(0, 8));
                  },
                  child: EditBox(
                    controller: profileProvider.nameController,
                    onChanged: (value) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    addError: addError(error: kNamelNullError),
                  ),
                ),
                const SizedBox(height: 10),
                // buildEditEmailFormField(),
                const SizedBox(height: 10),
                // buildEditNumberFormField(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await userProvider
                    .updateAllFields(
                      username: profileProvider.nameController.text,
                      email: profileProvider.emailController.text,
                      number: profileProvider.numberController.text,
                    )
                    .then((value) => Navigator.pop(context))
                    .catchError((e) => GetSnackBar(message: e.toString()));
              }
            },
            child: Container(
              width: double.infinity,
              height: getProportionateScreenHeight(60),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Done",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TextFormField buildEditUsernameFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.name,
  //     onSaved: (newValue) => _numberController.text = newValue!,
  //     style: TextStyle(fontSize: getProportionateScreenWidth(12)),
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kEmailNullError);
  //       } else if (emailValidatorRegExp.hasMatch(value)) {
  //         removeError(error: kInvalidEmailError);
  //       }
  //       return;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Username",
  //       hintText: userProvider.getUser?.email,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15),
  //         borderSide: const BorderSide(
  //           color: Colors.orange,
  //           width: 1.0,
  //         ),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(
  //         vertical: 2,
  //         horizontal: 16,
  //       ),
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon:
  //           const CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
  //     ),
  //   );
  // }

  // TextFormField buildEditEmailFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.name,
  //     onSaved: (newValue) => _emailController.text = newValue!,
  //     style: TextStyle(fontSize: getProportionateScreenWidth(12)),
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kEmailNullError);
  //       } else if (emailValidatorRegExp.hasMatch(value)) {
  //         removeError(error: kInvalidEmailError);
  //       }
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kEmailNullError);
  //         return "";
  //       } else if (!emailValidatorRegExp.hasMatch(value)) {
  //         addError(error: kInvalidEmailError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Email",
  //       hintText: userProvider.getUser?.email,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15),
  //         borderSide: const BorderSide(
  //           color: Colors.orange,
  //           width: 1.0,
  //         ),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(
  //         vertical: 2,
  //         horizontal: 16,
  //       ),
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
  //     ),
  //   );
  // }

  // TextFormField buildEditNumberFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.phone,
  //     obscureText: false,
  //     style: TextStyle(fontSize: getProportionateScreenWidth(12)),
  //     onSaved: (newValue) => _numberController.text = newValue!,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kPassNullError);
  //       } else if (value.length >= 8) {
  //         removeError(error: kShortPassError);
  //       }
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kPassNullError);
  //         return "";
  //       } else if (value.length < 8) {
  //         addError(error: kShortPassError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Number",
  //       hintText: "Enter your number",
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15),
  //         borderSide: const BorderSide(
  //           color: Colors.orange,
  //           width: 1.0,
  //         ),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(
  //         vertical: 2,
  //         horizontal: 16,
  //       ),
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
  //     ),
  //   );
  // }
}
