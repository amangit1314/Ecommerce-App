import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/splash/comonents/dot_indicator.dart';
import 'package:soni_store_app/screens/splash/comonents/splash_content.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../components/default_button.dart';
import '../../../models/splash.dart';
import '../../sign_in/sign_in_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Splash> splashData = [
    Splash(
        text: "Get Ready to Snap and Shop \n Where Convenience Meets Quality.",
        image:
            "https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/illustrationsAndSplash%2Fsplash_1.png?alt=media&token=fd816a87-08da-4349-a64c-7e6571d2c957"),
    Splash(
        text: "We help people conect with store \naround Rajasthan India",
        image:
            "https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/illustrationsAndSplash%2Fsplash_2.png?alt=media&token=b85a04fa-f2d6-4b43-9ac6-093b008d26e5"),
    Splash(
        text: "We show the easy way to shop. \nJust stay at home with us",
        image:
            "https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/illustrationsAndSplash%2Fsplash_3.png?alt=media&token=029169aa-1977-4346-85ca-ea96f9d8040e"),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index].image,
                  text: splashData[index].text,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => DotIndicator(
                          currentPage: currentPage,
                          index: index,
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: DefaultButton(
                        text: "Continue",
                        txtColor: Colors.white,
                        press: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
