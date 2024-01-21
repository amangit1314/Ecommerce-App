import 'package:flutter/material.dart';

import '../../../../components/default_button.dart';
import '../../../../utils/size_config.dart';
import '../../../sign_in/sign_in_screen.dart';
import '../../data/data.dart';

import 'dot_indicator.dart';
import 'splash_content.dart';

class SplashBody extends StatelessWidget {
  SplashBody({Key? key}) : super(key: key);
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

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
                  currentPageNotifier.value = value;
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
                          currentPage: currentPageNotifier.value,
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
