import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/resources/auth_methods.dart';
import 'package:soni_store_app/screens/profile/components/my_account.dart';
import 'package:soni_store_app/screens/splash/splash_screen.dart';

import '../../../utils/size_config.dart';
import 'profile_menu.dart';

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
            ProfilePic(),
            const SizedBox(height: 20),
            Column(
              children: [
                const SizedBox(height: 20),
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
                ProfileMenu(
                  text: "Notifications",
                  icon: "assets/icons/Bell.svg",
                  press: () {
                    // navigate to notification screen
                  },
                ),
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/Question mark.svg",
                  press: () {
                    showBottomSheet(
                      enableDrag: false,
                      context: context,
                      builder: (index) {
                        return BottomSheet(
                          animationController: bottomSheetAnimationController,
                          backgroundColor: Colors.white,
                          onClosing: () {},
                          builder: (index) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Help Center',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.circleXmark,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Story',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        'widget.product.description',
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Text('• '),
                                              Text(' PS4 Gaming Control'),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text('• '),
                                              Text(' PS4 Gaming Control'),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text('• '),
                                              Text(' PS4 Gaming Control'),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text('• '),
                                              Text(' PS4 Gaming Control'),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text('• '),
                                              Text(' PS4 Gaming Control'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text(
                                    'Style',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text(
                                    'Design',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text(
                                    'Fabric',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
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
