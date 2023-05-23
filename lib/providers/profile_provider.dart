import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soni_store_app/resources/firestore_methods.dart';

class ProfileProvider with ChangeNotifier {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final numberFocusNode = FocusNode();

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

  Future pickGalaryImage(BuildContext context) async {
    await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100)
        .then((value) {
      setImage(value!);
      uploadImage(context);
    });
  }

  Future pickCameraImage(BuildContext context) async {
    await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100)
        .then((value) => setImage(value!));
  }

  Future uploadImage(BuildContext context) async {
    setLoading(true);
    // upload image to firebase storage
    String imageUrl = await FirestoreMethods().uploadImageToStorage(
      'profile_images',
      _image! as Uint8List,
      false,
    );
    setLoading(false);
    Navigator.pop(context);
  }

  Future showUsernameDialogAlert(BuildContext context, String name) {
    _nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Change Username'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    focusNode: nameFocusNode,
                    decoration: InputDecoration(
                      hintText: name,
                    ),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
  }
}
