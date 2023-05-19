import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/user_provider.dart';
import 'package:soni_store_app/screens/profile/components/profile_pic.dart';
import 'package:soni_store_app/utils/constants.dart';
import 'package:soni_store_app/utils/size_config.dart';

import 'edit_box.dart';
import 'edit_email_box.dart';
import 'edit_number_box.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserProvider userProvider;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      _fetchCurrentUserDetails();
    });
  }

  void _fetchCurrentUserDetails() {
    if (userProvider.getUser != null) {
      setState(() {
        _nameController.text = userProvider.getUser!.username ?? 'Aman';
        _emailController.text = userProvider.getUser!.email;
        _numberController.text = userProvider.getUser!.number ?? '7023953453';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (userProvider.getUser != null) {
      _nameController.text = userProvider.getUser!.username ?? 'Aman';
      _emailController.text = userProvider.getUser!.email;
      _numberController.text = userProvider.getUser!.number ?? '7023953453';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                userProvider.updateUserDetails(
                  displayName: _nameController.text,
                );
                userProvider.updateUserEmail(email: _emailController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
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
                EditBox(
                  controller: _nameController,
                  label: 'Name',
                  onSaved: (newValue) {
                    userProvider.updateUserDetails(displayName: newValue);
                  },
                ),
                const SizedBox(height: 10),
                EditBoxEmail(
                  controller: _emailController,
                  icon: FontAwesomeIcons.envelope,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) {
                    userProvider.updateUserEmail(email: newValue);
                  },
                ),
                const SizedBox(height: 10),
                EditBoxPhone(
                  controller: _numberController,
                  icon: FontAwesomeIcons.mobile,
                  keyboardType: TextInputType.number,
                  label: 'Phone Number',
                  onSaved: (newValue) {
                    // Uncomment the lines below if you want to perform any action on saving the value
                    // userProvider.updateUserNumber(number: newValue);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(70),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  userProvider.updateUserDetails(
                    displayName: _nameController.text,
                  );
                  userProvider.updateUserEmail(email: _emailController.text);

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
