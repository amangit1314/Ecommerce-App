import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/screens/details/components/rating_tile.dart';

import '../../../models/models.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import 'add_review_screen.dart';

class ReviewsSheet extends StatelessWidget {
  const ReviewsSheet({
    super.key,
    required this.bottomSheetAnimationController,
    required this.product,
    required this.image,
  });

  final AnimationController bottomSheetAnimationController;
  final Product product;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: () {
          showBottomSheet(
            enableDrag: false,
            context: context,
            builder: (index) {
              return BottomSheet(
                // radius 16
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                animationController: bottomSheetAnimationController,
                backgroundColor: Colors.grey[900],
                onClosing: () {},
                builder: (index) {
                  return SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.grey[900],
                      body: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // * rating tile
                            const RatingTile(),

                            // divider
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 5,
                                right: 5,
                              ),
                              child: Divider(
                                height: 1,
                                color: kPrimaryColor.withOpacity(.3),
                              ),
                            ),

                            // * add review tile
                            GestureDetector(
                              onTap: () {
                                // navigate to add review screen
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AddReviewScreen(
                                      product: product,
                                      image: image,
                                    ),
                                  ),
                                );
                              },
                              child: const ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                leading: FaIcon(
                                  FontAwesomeIcons.comments,
                                  size: 20,
                                  color: kPrimaryColor,
                                ),
                                title: Text(
                                  "Add a review",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),

                            // divider
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 5,
                                right: 5,
                              ),
                              child: Divider(
                                height: 1,
                                color: kPrimaryColor.withOpacity(.3),
                              ),
                            ),

                            // * reviews list section header
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Reviews",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),

                            // * reviews list
                            SizedBox(
                              // expand size
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(15),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return const ReviewItemTile();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
              top: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
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
                    FontAwesomeIcons.starHalf,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  const Text(
                    "Reviews",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewItemTile extends StatelessWidget {
  const ReviewItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      height: 165,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // row with circleavatr, name, time, stars
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade600,
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/1.jpg'),
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "John Doe",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "2 days",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.star,
                      size: 15,
                      color: Colors.yellow.shade500,
                    ),
                    FaIcon(
                      FontAwesomeIcons.star,
                      size: 15,
                      color: Colors.yellow.shade500,
                    ),
                    FaIcon(
                      FontAwesomeIcons.star,
                      size: 15,
                      color: Colors.yellow.shade500,
                    ),
                    FaIcon(
                      FontAwesomeIcons.star,
                      size: 15,
                      color: Colors.yellow.shade500,
                    ),
                    FaIcon(
                      FontAwesomeIcons.star,
                      size: 15,
                      color: Colors.yellow.shade500,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // quoted text 4 line
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisi eget nunc ultricies aliquet. Sed vitae nisi eget nunc ultricies aliquet.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
