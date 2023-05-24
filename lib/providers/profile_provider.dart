import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soni_store_app/resources/firestore_methods.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode numberFocusNode = FocusNode();

  bool loading = false;

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get numberController => _numberController;

  void setImage(XFile image) {
    _image = image;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(String userId) async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage != null) {
      setImage(pickedImage);
      await uploadImage(userId);
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

  Future uploadImage(String userId) async {
    setLoading(true);
    String imageUrl = await FirestoreMethods().uploadImageToStorage(
      'profile_images/$userId',
      await _image!.readAsBytes(), // Convert XFile to Uint8List
      false,
    );
    setLoading(false);
    return imageUrl;
  }

  Future updateProfile(String userId) async {
    setLoading(true);
    String username = nameController.text;
    String email = emailController.text;
    String number = numberController.text;
    String imageUrl = image?.path ?? ''; // Use the image path if available

    await FirestoreMethods().updateProfile(
      userId,
      username,
      email,
      number,
      imageUrl,
    );

    setLoading(false);
  }
}
