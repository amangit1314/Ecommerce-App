import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constants.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Add Review',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
            )),
        // leading ios
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
        children: [
          // list tile with selected product image, selected product category and name(in bold

          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/iphone12.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            subtitle: const Text(
              'iPhone 12',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            title: const Text(
              'Mobile Phones',
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // select stars and stars should fill according to selection

          const SizedBox(height: 20),
          const Text(
            'Rate this product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.star,
                color: kPrimaryColor,
              ),
              Icon(
                Icons.star,
                color: kPrimaryColor,
              ),
              Icon(
                Icons.star,
                color: kPrimaryColor,
              ),
              Icon(
                Icons.star,
                color: kPrimaryColor,
              ),
              Icon(
                Icons.star,
                color: kPrimaryColor,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // text field for review
          const Text(
            'Review',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: kPrimaryColor,
              ),
            ),
            child: const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Write your review here',
                hintStyle: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // submit button
          GestureDetector(
            onTap: () {
              // submit review
              // navigate to home, with .push
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddReviewScreen(),
                ),
              );
            },
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryColor,
              ),
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
}
