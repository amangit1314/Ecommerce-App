import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: const Color(0xFFF5F6F9),
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: const BorderSide(color: Colors.white),
    ),
  );

  XFile? imageXFile;

  ImagePicker imagePicker = ImagePicker();

  getImageFromGalary() async {
    imageXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    print(imageXFile!.path);
    setState(() {
      imageXFile = imageXFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    // user provider isntance
    final userProvider = Provider.of<UserProvider>(context);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              userProvider.getUser?.profImage ??
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
            ),
          ),
          Positioned(
            right: 70,
            bottom: -6,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 23,
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 21,
                child: TextButton(
                  onPressed: () {
                    getImageFromGalary;
                    userProvider.updateUserProfileImage(
                      profileImage: getImageFromGalary().imageXFile!.path(),
                    );
                  },
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
