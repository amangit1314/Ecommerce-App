import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soni_store_app/resources/services/firebase/firestore_methods.dart';

import '../models/user.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _numberController = TextEditingController();
  TextEditingController get numberController => _numberController;

  XFile _image = XFile(
      'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000');
  XFile get image => _image;

  bool loading = false;
  final picker = ImagePicker();
  final usersCollection = FirebaseFirestore.instance.collection('users');

  void setUserFromAuthProvider(User user) {
    nameController.text = user.username ?? '';
    emailController.text = user.email;
    numberController.text = user.number ?? '';

    notifyListeners();
  }

  void setImage(XFile image) {
    _image = image;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future pickGalleryImage() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage != null) {
      setImage(pickedImage);
    }
  }

  Future pickCameraImage() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedImage != null) {
      setImage(pickedImage);
    }
  }

  Future<String> uploadImage(String userId) async {
    setLoading(true);

    try {
      String imageUrl = await FirestoreMethods().uploadImageToStorage(
        'profile_images/$userId',
        await _image.readAsBytes(), // Convert XFile to Uint8List
        false,
      );

      setLoading(false);
      return imageUrl;
    } catch (error) {
      setLoading(false);
      throw Exception('Failed to upload image: $error');
    }
  }

  Future<void> updateProfile(String userId) async {
    if (userId.isEmpty) {
      throw Exception('Empty or Invalid user ID');
    }

    setLoading(true);
    String username = nameController.text;
    String email = emailController.text;
    String number = numberController.text;
    String imageUrl = image.path; // Use the image path if available

    try {
      await usersCollection.doc(userId).update({
        'name': username,
        'email': email,
        'number': number,
        'photoURL': imageUrl,
      });
    } catch (error) {
      setLoading(false);
      throw Exception('Failed to update profile: $error');
    }

    setLoading(false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}
