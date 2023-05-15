import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';

import '../../../../utils/constants.dart';
import 'edit_profile_screen.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController numberController = TextEditingController();

    if (userProvider.getUser != null) {
      nameController.text = userProvider.getUser!.displayName ?? 'John';
      emailController.text = userProvider.getUser!.email ?? 'john@gmail.com';
      numberController.text = userProvider.getUser!.phoneNumber ?? '7023953453';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/edit-profile');
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
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage("assets/images/Profile Image.png"),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.getUser?.displayName ?? 'Aman Soni',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              userProvider.getUser?.email ?? 'login@gmail.com'),
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
                            userProvider.getUser?.displayName ?? 'Aman Soni',
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
                            userProvider.getUser?.phoneNumber ??
                                '+91 9649477393',
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
                        children: const [
                          Text('Gender'),
                          Text(
                            // userProvider.getUser?.gender ??
                            'Male',
                            style: TextStyle(
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
                            userProvider.getUser?.email ?? 'example@gmail.com',
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
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Change password',
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: const Color(0xFFF5F6F9),
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: const BorderSide(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage("assets/images/Profile Image.png"),
    );
  }
}
