import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    debugPrint('No Image Selected');
  }

  Uint8List? _image;

  XFile? selectedImage;

  selectImage(userProvider) async {
    Uint8List imageBytes = await pickImage(ImageSource.gallery) ?? Uint8List(0);
    if (imageBytes.isEmpty) return;

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images').child(imageName);

    UploadTask uploadTask = storageReference.putData(imageBytes);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String profileImage = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _image = imageBytes;
    });

    if (profileImage.isNotEmpty) {
      await userProvider.updateUserProfileImage(profileImage: profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          _image != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: MemoryImage(_image!),
                  backgroundColor: Colors.red,
                )
              : const CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                  backgroundColor: Colors.red,
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
                  onPressed: () async {
                    await selectImage(userProvider);
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
