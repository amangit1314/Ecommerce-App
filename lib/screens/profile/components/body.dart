import 'package:flutter/material.dart';
import 'package:soni_store_app/resources/auth_methods.dart';
import 'package:soni_store_app/screens/notification/notification_screen.dart';
import 'package:soni_store_app/screens/profile/components/my_account.dart';
import 'package:soni_store_app/screens/profile/settings.dart';
import 'package:soni_store_app/screens/splash/splash_screen.dart';

import '../help_center.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

  @override
  void initState() {
    super.initState();
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            Column(
              children: [
                const SizedBox(height: 20),
                // * My Account
                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyAccount(),
                      ),
                    ),
                  },
                ),

                // * Notifications
                ProfileMenu(
                  text: "Notifications",
                  icon: "assets/icons/Bell.svg",
                  press: () {
                    // navigate to notification screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                ),

                // * Settings
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ),
                    );
                  },
                ),

                // * Help Center
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/Question mark.svg",
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HelpCenter(),
                      ),
                    );
                  },
                ),

                // * Log Out
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () {
                    AuthMethods().signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
