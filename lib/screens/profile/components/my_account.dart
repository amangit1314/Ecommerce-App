import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/utils/constants.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../utils/size_config.dart';
import 'edit_profile_screen.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle kPrimaryBoldTextStyle = TextStyle(
      fontSize: 18,
      color: kPrimaryColor,
      fontWeight: FontWeight.w600,
    );
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
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
        child: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, authProvider, profileProvider, _) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Row(
                    children: [
                      authProvider.user.profImage != null
                          ? CircleAvatar(
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                authProvider.user.profImage!,
                              ),
                              backgroundColor: kPrimaryColor,
                            )
                          : const CircleAvatar(
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                'https://media.sketchfab.com/models/296f9f80c4ac431aa3d354f7ef955605/thumbnails/1d824d70f65e441a8f81162ff8bac094/281cbed7656443ffb04d2e38f928ab14.jpeg',
                              ),
                              backgroundColor: kPrimaryColor,
                            ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authProvider.user.username ?? 'Aman Soni',
                            style: kPrimaryBoldTextStyle,
                          ),
                          Text(
                            authProvider.user.email,
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: [
                      buildInfoRow(
                        context,
                        'Username',
                        authProvider.user.username ?? 'Aman Soni',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      buildInfoRow(
                        context,
                        'Phone number',
                        authProvider.user.number ?? '+91 1234567890',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      buildInfoRow(
                        context,
                        'Gender',
                        authProvider.user.gender ?? 'Not Specified',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      buildInfoRow(
                        context,
                        'Email',
                        authProvider.user.email,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: kPrimaryColor.withOpacity(.3),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 14,
                                color: kPrimaryColor.withOpacity(.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Center(
                                        child: Text(
                                          'Change Password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
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
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          suffixIcon: const CustomSurffixIcon(
                                            svgIcon: "assets/icons/Lock.svg",
                                          ),
                                        ),
                                        onChanged: (String newPassword) =>
                                            profileProvider.updatePassword(
                                          authProvider.user.uid,
                                        ),
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
                              child: Container(
                                // padding 8
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                // decoration color kPrimary border radius 12
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Change password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Widget buildInfoRow(BuildContext context, String title, String value) {
    TextStyle kInfoTitleTextStyle = TextStyle(
      fontSize: 14,
      color: kPrimaryColor.withOpacity(.8),
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kInfoTitleTextStyle,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  color: kTextColor,
                ),
          ),
        ],
      ),
    );
  }
}
