import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soni_store_app/providers/user_provider.dart';

class ImageMethods {
  Future<XFile?> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      XFile? image = await imagePicker.pickImage(source: source);
      return image;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  Future<void> selectImage(UserProvider userProvider) async {
    XFile? image = await pickImage(ImageSource.gallery);
    if (image == null) {
      debugPrint('No Image Selected');
      return;
    }

    Uint8List imageBytes = await image.readAsBytes();
    if (imageBytes.isEmpty) return;

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images').child(imageName);

    try {
      UploadTask uploadTask = storageReference.putData(imageBytes);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String profileImage = await taskSnapshot.ref.getDownloadURL();
      userProvider.updateProfileImage(profileImage: profileImage);
    } catch (e) {
      debugPrint('Error uploading image: $e');
    }
  }
}
