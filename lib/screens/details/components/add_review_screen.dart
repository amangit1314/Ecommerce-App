import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/models/models.dart';

import '../../../utils/constants.dart';

class AddReviewScreen extends StatefulWidget {
  final Product product;
  final String image;
  const AddReviewScreen(
      {super.key, required this.product, required this.image});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  late TextEditingController _ratingController;
  late final double _rating;

  final double _initialRating = 2.0;
  final bool _isVertical = false;

  bool turnedOn = false;
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
              widget.product.categories.first.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            title: Text(
              widget.product.title.toString(),
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
                  initialRating: _initialRating,
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
                      _ratingController.text = rating.toString();
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
                const ReviewCommentInputField(),
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
          // * Add review button
          GestureDetector(
            onTap: () {
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

class ReviewCommentInputField extends StatelessWidget {
  const ReviewCommentInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPrimaryColor),
      ),
      child: TextField(
        maxLines: 5,
        style: TextStyle(
          color: Colors.black.withOpacity(.8),
          fontSize: 14,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Write your review here',
          hintStyle: TextStyle(
            color: kPrimaryColor.withOpacity(.8),
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.all(6),
        ),
      ),
    );
  }
}

class ReviewRatingInputField extends StatelessWidget {
  const ReviewRatingInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kPrimaryColor,
        ),
      ),
      child: TextField(
        maxLines: 5,
        style: TextStyle(
          color: Colors.black.withOpacity(.8),
          fontSize: 14,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Give rating ...',
          hintStyle: TextStyle(
            color: kPrimaryColor.withOpacity(.8),
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.all(6),
        ),
      ),
    );
  }
}
