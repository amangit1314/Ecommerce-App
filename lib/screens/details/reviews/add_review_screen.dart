import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/review.dart';
import 'package:soni_store_app/providers/review_provider.dart';

import '../../../helper/locator.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class AddReviewScreen extends StatefulWidget {
  final String category;
  final String name;
  final String image;
  final String productId;

  const AddReviewScreen({
    Key? key,
    required this.image,
    required this.category,
    required this.name,
    required this.productId,
  }) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  late TextEditingController commentController;
  double _rating = 2.0;
  final bool _isVertical = false;
  bool turnedOn = false;
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = locator<ReviewProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Add Review',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenHeight(16),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(builder: (context, authProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  height: getProportionateScreenHeight(80),
                  width: getProportionateScreenWidth(80),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(16)),
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                subtitle: Text(
                  widget.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                title: Text(
                  widget.name,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding:
                    EdgeInsets.only(left: getProportionateScreenHeight(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(12)),
                      child: const Divider(height: 1, color: kPrimaryColor),
                    ),
                    Text(
                      'Rate this product',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenHeight(12),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: _isVertical ? Axis.vertical : Axis.horizontal,
                      allowHalfRating: true,
                      unratedColor: kPrimaryColor.withAlpha(50),
                      itemCount: 5,
                      itemSize: 30.0,
                      itemBuilder: (context, _) => Icon(
                        _selectedIcon ?? Icons.star,
                        color: kPrimaryColor,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(12),
                          bottom: getProportionateScreenHeight(12)),
                      child: const Divider(height: 1, color: kPrimaryColor),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set a Rating for this product',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(12)),
                        const ReviewRatingInputField(),
                        SizedBox(height: getProportionateScreenHeight(2)),
                        Text(
                          '100 Character max',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(8),
                            wordSpacing: getProportionateScreenWidth(1.2),
                            color: kPrimaryColor.withOpacity(.7),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding:
                    EdgeInsets.only(left: getProportionateScreenHeight(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What did you like or dislike?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenHeight(12),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    ReviewCommentInputField(controller: commentController),
                    SizedBox(height: getProportionateScreenHeight(2)),
                    Text(
                      '3000 Character max',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(8),
                        wordSpacing: getProportionateScreenWidth(1.2),
                        color: kPrimaryColor.withOpacity(.7),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(20),
                    left: getProportionateScreenHeight(20),
                    right: getProportionateScreenHeight(20)),
                child: const Divider(height: 1, color: kPrimaryColor),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Would you recommend this product?',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(12),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    buildIOSSwitch(),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              GestureDetector(
                onTap: () async {
                  final review = Review(
                    comment: commentController.text,
                    stars: _rating,
                    reviewerName: authProvider.user.username ?? 'SnapCart User',
                    when: DateTime.now().toString(),
                    isRecommend: turnedOn,
                    reviewerPic: authProvider.user.profImage!,
                  );

                  await reviewProvider.addReviewToProduct(
                      review, widget.productId);
                  if (!mounted) return;
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: getProportionateScreenHeight(50),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(10)),
                    color: kPrimaryColor,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Center(
                    child: Text(
                      'Submit Review',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildIOSSwitch() => Transform.scale(
        scale: getProportionateScreenHeight(1.1),
        child: CupertinoSwitch(
          activeColor: kPrimaryColor.withOpacity(.5),
          trackColor: kTextColor,
          thumbColor: kPrimaryColor,
          value: turnedOn,
          onChanged: (value) => setState(() => turnedOn = value),
        ),
      );
}

class ReviewRatingInputField extends StatelessWidget {
  const ReviewRatingInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
        color: Colors.grey.withOpacity(.2),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 3,
        style: TextStyle(fontSize: getProportionateScreenHeight(14)),
        decoration: InputDecoration(
          counterText: '',
          hintText: 'Enter your rating ...',
          contentPadding: EdgeInsets.only(
            left: getProportionateScreenWidth(10),
            top: getProportionateScreenWidth(10),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class ReviewCommentInputField extends StatelessWidget {
  final TextEditingController controller;

  const ReviewCommentInputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(.2),
      ),
      child: TextField(
        controller: controller,
        maxLines: 6,
        maxLength: 3000,
        style: TextStyle(fontSize: getProportionateScreenHeight(14)),
        decoration: InputDecoration(
          counterText: '',
          hintText: 'Write your review here...',
          contentPadding: EdgeInsets.only(
            left: getProportionateScreenWidth(10),
            top: getProportionateScreenWidth(10),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
