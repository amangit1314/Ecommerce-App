import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoto_ecommerce_app/providers/user_provider.dart';
import 'package:tokoto_ecommerce_app/screens/home/home_screen.dart';
import 'package:tokoto_ecommerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:tokoto_ecommerce_app/screens/splash/splash_screen.dart';

class EcommerceApp extends StatefulWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  bool _isOnboarded = false;

  @override
  void initState() {
    super.initState();
    _isOnboarded = true;
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('loggedin');

    if (loggedIn == true) {
      return const HomeScreen();
    } else {
      return const SignInScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: GetMaterialApp(
        title: 'Tokoto Ecommerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.orange,
        ),
        home: _isOnboarded
            ? FutureBuilder(
                future: autoLogin(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return const HomeScreen();
                  } else {
                    return const SignInScreen();
                  }
                },
              )
            : const SplashScreen(),
      ),
    );
  }
}
