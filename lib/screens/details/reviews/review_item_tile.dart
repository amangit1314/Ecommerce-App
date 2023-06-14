import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviewItemTile extends StatelessWidget {
  const ReviewItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      height: 165,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // row with circleavatr, name, time, stars
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white54,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/1.jpg'),
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("John Doe",
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(width: 5),
                    Text(
                      "2 days",
                      style: Theme.of(context).textTheme.bodySmall,
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
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisi eget nunc ultricies aliquet. Sed vitae nisi eget nunc ultricies aliquet.",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
