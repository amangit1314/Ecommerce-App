import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';

import '../../../../utils/constants.dart';
import 'edit_profile_screen.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    // int selectedImage = 0;

    // final CollectionReference productsRef =
    //     FirebaseFirestore.instance.collection('products');
    // late Stream<QuerySnapshot> productsStream;

    // @override
    // void initState() {
    //   super.initState();
    //   productsStream = productsRef.snapshots();
    // }

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        // if userprovider.getUser.prhotoURL is not null then only show network images otherwise show assetimage
                        backgroundImage: NetworkImage(
                          userProvider.getUser?.profImage ??
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                        ),

                        // backgroundImage:
                        //      AssetImage("assets/images/Profile Image.png"),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.getUser?.username ?? 'Aman Soni',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userProvider.getUser?.email ?? 'login@gmail.com',
                          ),
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
                            userProvider.getUser?.username ?? 'Aman Soni',
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
                            userProvider.getUser?.number ?? '+91 9649477393',
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
                            userProvider.getUser?.gender ?? 'Male',
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
                            onPressed: () {
                              // use reset -password method of userProvider
                              userProvider.resetPassword(
                                email: userProvider.getUser?.email ??
                                    'gitaman8481@gmail.com',
                              );
                            },
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
            );
          },
        ),
      ),
    );
  }
}
