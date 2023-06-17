import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/components/custom_surfix_icon.dart';
import 'package:soni_store_app/components/form_error.dart';
import 'package:soni_store_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:soni_store_app/screens/login_success/login_success_screen.dart';

import '../../../components/default_button.dart';
import '../../../providers/providers.dart';
import '../../../utils/constatns.dart';
import '../../../utils/size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool remember = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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

  Future loginUser(AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final result = await authProvider.authenticateUser(
        email: emailController.text,
        password: passwordController.text,
      );
      if (result == "success") {
        const GetSnackBar(
          title: 'Authentication Successful',
          message: 'Authentication is successful 🥳🎉',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginSuccessScreen()),
          (route) => false,
        );
      } else {
        GetSnackBar(
          title: 'Authentication Error',
          message: result.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: remember,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        remember = value!;
                      });
                    },
                  ),
                  const Text("Remember me"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ForgotPasswordScreen.routeName,
                  ),
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(14),
            ),
            child: DefaultButton(
              txtColor: Colors.white,
              text: "Continue",
              press: () => loginUser(authProvider),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onSaved: (newValue) => passwordController.text = newValue!,
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
        labelText: "Password",
        hintText: "Enter your password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => emailController.text = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
