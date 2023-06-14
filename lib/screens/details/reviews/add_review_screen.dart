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
        title: const Text(
          'Add Review',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 16,
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
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Divider(height: 1, color: kPrimaryColor),
                    ),
                    const Text(
                      'Rate this product',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12),
                      child: Divider(height: 1, color: kPrimaryColor),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Set a Rating for this product',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const ReviewRatingInputField(),
                        const SizedBox(height: 2),
                        Text(
                          '100 Character max',
                          style: TextStyle(
                            fontSize: 8,
                            wordSpacing: 1.2,
                            color: kPrimaryColor.withOpacity(.7),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What did you like or dislike?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReviewCommentInputField(controller: commentController),
                    const SizedBox(height: 2),
                    Text(
                      '3000 Character max',
                      style: TextStyle(
                        fontSize: 8,
                        wordSpacing: 1.2,
                        color: kPrimaryColor.withOpacity(.7),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Divider(height: 1, color: kPrimaryColor),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Would you recommend this product?',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildIOSSwitch(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final review = Review(
                    comment: commentController.text,
                    stars: _rating,
                    reviewerName: '',
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
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Center(
                    child: Text(
                      'Submit Review',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
        scale: 1.1,
        child: CupertinoSwitch(
          activeColor: kPrimaryColor.withOpacity(.5),
          trackColor: Colors.black,
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
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(.2),
      ),
      child: const TextField(
        keyboardType: TextInputType.number,
        maxLength: 3,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          counterText: '',
          hintText: 'Enter a rating',
          contentPadding: EdgeInsets.only(left: 10, top: 10),
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
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          counterText: '',
          hintText: 'Write your review here...',
          contentPadding: EdgeInsets.only(left: 10, top: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
