import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../splash/ui/splash_screen.dart';
import '../help_center_screen.dart';
import '../my_account_screen.dart';
import '../settings_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> with TickerProviderStateMixin {
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

                // * Settings
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
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
                        builder: (context) => const HelpCenterScreen(),
                      ),
                    );
                  },
                ),

                // * Log Out
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () async {
                    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                    await authProvider.signOut().then(
                      (value) {
                        if (!mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const SplashScreen()),
                          (route) => false,
                        );
                      },
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
