import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({super.key});

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen>
    with TickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

  @override
  void initState() {
    super.initState();
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomSheetAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Orders",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Orders history',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: 10,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (index) {
                    return BottomSheet(
                      animationController: bottomSheetAnimationController,
                      backgroundColor: Colors.grey[200],
                      onClosing: () {},
                      builder: (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Product Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
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
                              // Container(
                              //   height: 40,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[300],
                              //     borderRadius: BorderRadius.circular(10),
                              //     image: const DecorationImage(
                              //       image: AssetImage('assets/images/'),
                              //     ),
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Story',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
              child: Container(
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  // border on top and bottom side
                  border: Border(
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.googleWallet,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text(
                          "Processing",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          // height: 5,
                          // width: 8,
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 2,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '0',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: 10,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (index) {
                    return BottomSheet(
                      animationController: bottomSheetAnimationController,
                      backgroundColor: Colors.grey[200],
                      onClosing: () {},
                      builder: (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Product Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
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
                              // Container(
                              //   height: 40,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[300],
                              //     borderRadius: BorderRadius.circular(10),
                              //     image: const DecorationImage(
                              //       image: AssetImage('assets/images/'),
                              //     ),
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Story',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
              child: Container(
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  // border on top and bottom side
                  border: Border(
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.wallet,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text(
                          "Awaiting Payments",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          // height: 5,
                          // width: 8,
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 2,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '0',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: 10,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (index) {
                    return BottomSheet(
                      animationController: bottomSheetAnimationController,
                      backgroundColor: Colors.grey[200],
                      onClosing: () {},
                      builder: (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Product Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
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
                              // Container(
                              //   height: 40,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[300],
                              //     borderRadius: BorderRadius.circular(10),
                              //     image: const DecorationImage(
                              //       image: AssetImage('assets/images/'),
                              //     ),
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Story',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
              child: Container(
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  // border on top and bottom side
                  border: Border(
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.truckDroplet,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text(
                          "Delivered",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          // height: 5,
                          // width: 8,
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 2,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '0',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: 10,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (index) {
                    return BottomSheet(
                      animationController: bottomSheetAnimationController,
                      backgroundColor: Colors.grey[200],
                      onClosing: () {},
                      builder: (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Product Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
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
                              // Container(
                              //   height: 40,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[300],
                              //     borderRadius: BorderRadius.circular(10),
                              //     image: const DecorationImage(
                              //       image: AssetImage('assets/images/'),
                              //     ),
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Story',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
              child: Container(
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  // border on top and bottom side
                  border: Border(
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.caretLeft,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text(
                          "Returned",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          // height: 5,
                          // width: 8,
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 2,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '0',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: 10,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (index) {
                    return BottomSheet(
                      animationController: bottomSheetAnimationController,
                      backgroundColor: Colors.grey[200],
                      onClosing: () {},
                      builder: (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Product Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
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
                              // Container(
                              //   height: 40,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[300],
                              //     borderRadius: BorderRadius.circular(10),
                              //     image: const DecorationImage(
                              //       image: AssetImage('assets/images/'),
                              //     ),
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Story',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
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
              child: Container(
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  // border on top and bottom side
                  border: Border(
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.circleXmark,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text(
                          "Cancled",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          // height: 5,
                          // width: 8,
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 2,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '0',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.wallet),
    );
  }
}
