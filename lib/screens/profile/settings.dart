import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

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

  Widget buildIOSSwitch() => Transform.scale(
        scale: 1.1,
        child: CupertinoSwitch(
          activeColor: kPrimaryColor.withOpacity(.5),
          trackColor: Colors.black,
          thumbColor: kPrimaryColor,
          value: _notificationPermissionEnabled,
          onChanged: (_) => _toggleNotificationPermission(),
        ),
      );

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
        // centerTitle: true,
      ),
      body: Column(
        children: [
          // image with 300 height
          // SizedBox(
          //   height: 240,
          //   child: Image.network(
          //     "https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/illustrationsAndSplash%2Fsettings.png?alt=media&token=79a2fd6d-7c2f-4b08-8de0-e4046d4b214c",
          //   ),
          // ),
          Column(
            children: [
              // sized box 20
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          'Turn on & off notifications',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    // fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                    buildIOSSwitch(),
                  ],
                ),
              )
              // SwitchListTile(
              //   title: const Text('Notifications'),
              //   value: _notificationPermissionEnabled,
              //   onChanged: (_) => _toggleNotificationPermission(),
              // ),
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
        ],
      ),
    );
  }
}
