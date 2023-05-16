import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // back to previous screen
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kPrimaryColor,
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        actions: [
          // logout icon
          IconButton(
            onPressed: () {
              // logout
            },
            icon: const Icon(
              Icons.logout,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      // design a settings screen
      body: Column(
        children: [
          // list of settings
          Expanded(
            child: ListView(
              children: [
                // list tile for change password

                // list tile for change language
                ListTile(
                  onTap: () {
                    // navigate to change language screen
                  },
                  leading: const Icon(
                    Icons.language,
                    color: kPrimaryColor,
                  ),
                  title: const Text('Change Language'),
                  // subtitle in 3 lines about title
                  subtitle: const Text(
                    'English',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: buildIOSSwitch(),
                ),
                // list tile for change currency
                ListTile(
                  onTap: () {
                    // navigate to change currency screen
                  },
                  leading: const FaIcon(
                    FontAwesomeIcons.ticket,
                    color: kPrimaryColor,
                  ),
                  title: const Text('Change Currency'),

                  // subtitle in 3 lines about title
                  subtitle: const Text(
                    'USD',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: buildIOSSwitch(),
                ),
                // list tile for change theme
                ListTile(
                  onTap: () {
                    // navigate to change theme screen
                  },
                  leading: const Icon(
                    Icons.color_lens,
                    color: kPrimaryColor,
                  ),
                  title: const Text('Change Theme'),
                  // subtitle in 3 lines about title
                  subtitle: const Text(
                    'Light',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: buildIOSSwitch(),
                ),
                // list tile for change notification
                ListTile(
                  onTap: () {
                    // navigate to change notification screen
                  },
                  leading: SvgPicture.asset(
                    "assets/icons/Bell.svg",
                    color: kPrimaryColor,
                    width: 18,
                  ),
                  title: const Text('Notification'),
                  // subtitle in 3 lines about title
                  subtitle: const Text(
                    'On',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // switch ui
                  trailing: buildIOSSwitch(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIOSSwitch() => Transform.scale(
        scale: 1.1,
        child: CupertinoSwitch(
          // border should be orange and the dial should be orange except that all will be of transparent color
          activeColor: kPrimaryColor.withOpacity(.5),
          trackColor: Colors.black,
          thumbColor: kPrimaryColor,
          // track border

          value: value,
          onChanged: (value) => setState(() => this.value = value),
        ),
      );
}
