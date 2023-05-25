import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/components/default_button.dart';
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../providers/user_provider.dart';
import 'edit_profile_screen.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            child: const Text('Edit'),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return Column(
              children: [
                // * header tile
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: userProvider.user.profImage != null
                            ? NetworkImage(userProvider.user.profImage!)
                            : const AssetImage(
                                    'assets/images/default_profile_image.png')
                                as ImageProvider,
                        backgroundColor: Colors.red,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.user.username ?? 'Aman Soni',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(userProvider.user.email),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Username'),
                          Text(
                            userProvider.user.username ?? 'Aman Soni',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Divider(
                          color: kPrimaryColor,
                          height: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Phone number'),
                          Text(
                            userProvider.user.number ?? '+91 9649477393',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Divider(
                          color: kPrimaryColor,
                          height: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Gender'),
                          Text(
                            userProvider.user.gender ?? 'Male',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Divider(
                          color: kPrimaryColor,
                          height: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Email'),
                          Text(
                            userProvider.user.email,
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Divider(
                          color: kPrimaryColor,
                          height: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Password'),
                          SizedBox(
                            width: getProportionateScreenWidth(190),
                            child: DefaultButton(
                                txtColor: Colors.white,
                                press: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        title: Center(
                                          child: Text(
                                            'Change Password',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryColor,
                                                ),
                                          ),
                                        ),
                                        content: TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintStyle:
                                                const TextStyle(fontSize: 14),
                                            hintText: "Enter new password",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: const BorderSide(
                                                color: Colors.orange,
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 16,
                                            ),
                                            // If  you are using latest version of flutter then lable text and hint text shown like this
                                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            suffixIcon: const CustomSurffixIcon(
                                                svgIcon:
                                                    "assets/icons/Lock.svg"),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Change'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                text: 'Change password'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
