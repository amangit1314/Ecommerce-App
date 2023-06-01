import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationPermissionEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkNotificationPermissionStatus();
  }

  void _checkNotificationPermissionStatus() async {
    final status = await Permission.notification.status;
    setState(() {
      _notificationPermissionEnabled = status.isGranted;
    });
  }

  void _toggleNotificationPermission() async {
    if (!_notificationPermissionEnabled) {
      final status = await Permission.notification.request();
      setState(() {
        _notificationPermissionEnabled = status.isGranted;
      });
    } else {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          // image with 300 height
          SizedBox(
            height: 300,
            child: Image.asset("assets/settings.png"),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: const Text('Notifications'),
                  value: _notificationPermissionEnabled,
                  onChanged: (_) => _toggleNotificationPermission(),
                ),
                // ListTile(
                //   onTap: () {},
                //   leading: const FaIcon(
                //     FontAwesomeIcons.ticket,
                //     color: kPrimaryColor,
                //   ),
                //   title: const Text('Change Currency'),
                //   subtitle: const Text(
                //     'USD',
                //     maxLines: 3,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                //   trailing: buildIOSSwitch(),
                // ),
                // ListTile(
                //   onTap: () {},
                //   leading: ColorFiltered(
                //     colorFilter:
                //         const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                //     child: SvgPicture.asset(
                //       "assets/icons/Bell.svg",
                //       width: 18,
                //     ),
                //   ),
                //   title: const Text('Notification'),
                //   subtitle: const Text(
                //     'On',
                //     maxLines: 3,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                //   trailing: buildIOSSwitch(),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildIOSSwitch() => Transform.scale(
  //       scale: 1.1,
  //       child: CupertinoSwitch(
  //         activeColor: kPrimaryColor.withOpacity(.5),
  //         trackColor: Colors.black,
  //         thumbColor: kPrimaryColor,
  //         value: value,
  //         onChanged: (value) => setState(() => this.value = value),
  //       ),
  //     );
}
