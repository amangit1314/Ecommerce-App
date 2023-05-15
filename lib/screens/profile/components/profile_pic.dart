import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: const Color(0xFFF5F6F9),
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: const BorderSide(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/1.jpg"),
          ),
          Positioned(
            right: 100,
            bottom: -6,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 23,
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 21,
                child: TextButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    "assets/icons/Camera Icon.svg",
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
