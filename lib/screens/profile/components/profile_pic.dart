// ignore_for_file: unused_field

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/auth_provider.dart';

import '../../../utils/constants.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  bool _isImagePickerActive = false;
  Uint8List? _image;
  XFile? selectedImage;

  pickImage(ImageSource source) async {
    if (_isImagePickerActive) {
      return;
    }

    _isImagePickerActive = true;

    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: source);
      if (file != null) {
        return await file.readAsBytes();
      }
      debugPrint('No Image Selected');
    } catch (error) {
      debugPrint('Failed to pick image: $error');
    } finally {
      _isImagePickerActive = false;
    }
  }

  selectImage(AuthProvider authProvider) async {
    Uint8List imageBytes = await pickImage(ImageSource.gallery) ?? Uint8List(0);
    if (imageBytes.isEmpty) return;

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images').child(imageName);

    UploadTask uploadTask = storageReference.putData(imageBytes);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      log('Profile Image Uploaded');
    });

    String profileImage = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _image = imageBytes;
    });

    if (profileImage.isNotEmpty) {
      await authProvider.updateUserField(
        authProvider.user.uid,
        'profImage',
        profileImage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          authProvider.user.profImage != null
              ? CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    authProvider.user.profImage!,
                  ), // Cast AssetImage to ImageProvider
                  backgroundColor: kPrimaryColor,
                )
              : const CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://media.sketchfab.com/models/296f9f80c4ac431aa3d354f7ef955605/thumbnails/1d824d70f65e441a8f81162ff8bac094/281cbed7656443ffb04d2e38f928ab14.jpeg',
                  ), // Cast AssetImage to ImageProvider
                  backgroundColor: kPrimaryColor,
                ),
          Positioned(
            right: 5,
            bottom: -10,
            left: 75,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 23,
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 21,
                child: TextButton(
                  onPressed: () async {
                    authProvider.updateUserField(
                      authProvider.user.uid,
                      'profImage',
                      selectImage(authProvider),
                    );
                    await selectImage(authProvider);
                  },
                  child: SvgPicture.asset(
                    "assets/icons/Camera Icon.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
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
