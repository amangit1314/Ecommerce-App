import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/models.dart';
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/utils/constants.dart';
import 'package:soni_store_app/utils/size_config.dart';

import 'profile_pic.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    final currentUser = userProvider.getUser;

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          const ProfilePic(),
          SizedBox(height: getProportionateScreenHeight(40)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                buildEditUsernameFormField(
                    userProvider, profileProvider, currentUser),
                SizedBox(height: getProportionateScreenHeight(16)),
                buildEditEmailFormField(
                    userProvider, profileProvider, currentUser),
                SizedBox(height: getProportionateScreenHeight(16)),
                buildEditNumberFormField(
                    userProvider, profileProvider, currentUser),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await profileProvider.updateProfile(currentUser.uid).then(
                      (value) => Navigator.pop(context),
                    );
              }
            },
            child: Container(
              width: double.infinity,
              height: getProportionateScreenHeight(60),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "Done",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(14),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildEditUsernameFormField(UserProvider userProvider,
      ProfileProvider profileProvider, User currentUser) {
    return TextFormField(
      style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
      ),
      controller: profileProvider.nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a username";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: currentUser.username ?? currentUser.email.substring(0, 8),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.account_circle_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }

  TextFormField buildEditEmailFormField(UserProvider userProvider,
      ProfileProvider profileProvider, User currentUser) {
    return TextFormField(
      style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
      ),
      controller: profileProvider.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter an email";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: currentUser.email,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }

  TextFormField buildEditNumberFormField(UserProvider userProvider,
      ProfileProvider profileProvider, User currentUser) {
    return TextFormField(
      style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
      ),
      controller: profileProvider.numberController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a phone number";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: currentUser.number ?? "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}
