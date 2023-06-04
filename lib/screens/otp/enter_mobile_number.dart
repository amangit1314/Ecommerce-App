import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/otp/otp_screen.dart';

import '../../components/custom_surfix_icon.dart';
import '../../components/default_button.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> _sendOTP() async {
    String phoneNumber =
        '+91${_mobileNumberController.text}'; // Customize the country code if needed
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieve the OTP on certain devices
        _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failed errors
        log('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Navigate to the OTP verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Enter Number",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // container with 330 h
              SizedBox(
                height: 330,
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/illustrationsAndSplash%2Fmobile.png?alt=media&token=b1580210-4eac-4780-8282-9a2f96af2ce6",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 45.0),
              buildNumberFormField(_mobileNumberController),
              const SizedBox(height: 15.0),
              DefaultButton(
                txtColor: Colors.white,
                text: "Send OTP",
                press: _sendOTP,
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildNumberFormField(TextEditingController controller) {
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onSaved: (newValue) => controller.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Number",
        hintText: "Enter Mobile Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
