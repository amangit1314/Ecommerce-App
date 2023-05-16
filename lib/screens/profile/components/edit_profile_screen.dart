import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // user provider instance

  @override
  void initState() {
    super.initState();
    _nameController.text = "Soni";
    _emailController.text = "cart@gmail.com";
    _numberController.text = "7023953453";
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    if (userProvider.getUser != null) {
      _nameController.text = userProvider.getUser!.username ?? 'John';
      _emailController.text = userProvider.getUser!.email;
      _numberController.text = userProvider.getUser!.number ?? '7023953453';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save'),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ProfilePic(),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                EditBox(
                  controller: _nameController,
                  icon: FontAwesomeIcons.user,
                ),
                const SizedBox(height: 10),
                EditBoxEmail(
                  controller: _emailController,
                  icon: FontAwesomeIcons.envelope,
                ),
                const SizedBox(height: 10),
                EditBoxPhone(
                  controller: _numberController,
                  icon: FontAwesomeIcons.phone,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(70),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  userProvider.updateUserDetails(
                    displayName: _nameController.text,
                  );
                  userProvider.updateUserEmail(email: _emailController.text);
                  // userProvider.updateUserNumber(number: _numberController.text);
                  //userProvider.updateUserProfileImage(profileImage: profileImage)
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditBox extends StatefulWidget {
  const EditBox({super.key, required this.controller, this.icon});
  final TextEditingController controller;
  final IconData? icon;

  @override
  State<EditBox> createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FaIcon(
              widget.icon,
              color: kPrimaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InputDecorator(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              child: TextFormField(
                onSaved: (newValue) {
                  widget.controller.text = newValue!;
                  userProvider.updateUserDetails(
                    displayName: widget.controller.text,
                  );
                },
                onChanged: (newValue) {
                  widget.controller.text = newValue;
                  userProvider.updateUserDetails(
                    displayName: widget.controller.text,
                  );
                },
                controller: widget.controller,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditBoxEmail extends StatefulWidget {
  const EditBoxEmail({super.key, required this.controller, this.icon});
  final TextEditingController controller;
  final IconData? icon;

  @override
  State<EditBoxEmail> createState() => _EditBoxEmailState();
}

class _EditBoxEmailState extends State<EditBoxEmail> {
  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FaIcon(
              widget.icon,
              color: kPrimaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InputDecorator(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              child: TextFormField(
                onSaved: (newValue) {
                  widget.controller.text = newValue!;
                  userProvider.updateUserEmail(email: widget.controller.text);
                },
                onChanged: (newValue) {
                  widget.controller.text = newValue;
                  userProvider.updateUserEmail(
                    email: widget.controller.text,
                  );
                },
                controller: widget.controller,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditBoxPhone extends StatefulWidget {
  const EditBoxPhone({super.key, required this.controller, this.icon});
  final TextEditingController controller;
  final IconData? icon;

  @override
  State<EditBoxPhone> createState() => _EditBoxPhoneState();
}

class _EditBoxPhoneState extends State<EditBoxPhone> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              widget.icon,
              size: 20,
              color: kPrimaryColor,
            ),
          ),
          const Text(
            '+91 ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(
            child: Text(
              '| ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: InputDecorator(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              child: TextFormField(
                onSaved: (newValue) {
                  widget.controller.text = newValue!;
                  // userProvider.updateUserNumber(
                  //   number: widget.controller.text,
                  // );
                },
                onChanged: (newValue) {
                  widget.controller.text = newValue;
                  // userProvider.updateUserNumber(
                  //   number: widget.controller.text,
                  // );
                },
                controller: widget.controller,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  final String? profImage;

  const ProfilePic({
    this.profImage,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  XFile? imageXFile;
  ImagePicker imagePicker = ImagePicker();

  Future<void> getImageFromGallery() async {
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imageXFile = pickedFile;
        });
        print(imageXFile!.path);
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

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
      child: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            const CircleAvatar(
              // fetch and deisplay the updated image here as Network image, if no image then show assetimage
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
                    onPressed: () async {
                      await getImageFromGallery();
                      if (imageXFile != null) {
                        userProvider.updateUserProfileImage(
                          profileImage: imageXFile!.path,
                        );
                      } else {
                        print('No image selected');
                      }
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
        );
      }),
    );
  }
}
