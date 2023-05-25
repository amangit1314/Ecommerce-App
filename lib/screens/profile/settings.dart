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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.language,
                    color: kPrimaryColor,
                  ),
                  title: const Text('Change Language'),
                  subtitle: const Text(
                    'English',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: buildIOSSwitch(),
                ),
                ListTile(
                  onTap: () {},
                  leading: const FaIcon(
                    FontAwesomeIcons.ticket,
                    color: kPrimaryColor,
                  ),
                  title: const Text('Change Currency'),
                  subtitle: const Text(
                    'USD',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: buildIOSSwitch(),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.color_lens,
                    color: kPrimaryColor,
                  ),
                  title: const Text('Change Theme'),
                  subtitle: const Text(
                    'Light',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: buildIOSSwitch(),
                ),
                ListTile(
                  onTap: () {},
                  leading: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        kPrimaryColor, BlendMode.srcOver),
                    child: SvgPicture.asset(
                      "assets/icons/Bell.svg",
                      width: 18,
                    ),
                  ),
                  title: const Text('Notification'),
                  subtitle: const Text(
                    'On',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
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
          activeColor: kPrimaryColor.withOpacity(.5),
          trackColor: Colors.black,
          thumbColor: kPrimaryColor,
          value: value,
          onChanged: (value) => setState(() => this.value = value),
        ),
      );
}
