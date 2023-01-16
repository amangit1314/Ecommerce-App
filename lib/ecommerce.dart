import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/user_provider.dart';
import 'package:soni_store_app/screens/home/home_screen.dart';
import 'package:soni_store_app/screens/sign_in/sign_in_screen.dart';

class EcommerceApp extends StatefulWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  // bool _isOnboarded = false;

  // // function to show splash screen if not onboarded and if onboarded then show login screen
  // void isOnboarded() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     setState(() {
  //       _isOnboarded = true;
  //     });
  //   });
  // }

  // autoLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? loggedIn = prefs.getBool('loggedin');

  //   if (loggedIn == true) {
  //     return const LoginSuccessScreen();
  //   } else {
  //     return const SignInScreen();
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   //autoLogin();
  //   //isOnboarded();
  // }

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
          home:
              // _isOnboarded
              //     ?
              StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return const HomeScreen();
                        // : const SignInScreen();
                      }
                      //return GetSnackBar(message: snapshot.hasError.toString());
                      return const SignInScreen();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SignInScreen();
                  })
          //: const SplashScreen(),
          ),
    );
  }
}

// StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData) {
//               return const NavPage();
//             }
//             return Center(
//               child: showSnackBar(context, snapshot.hasError.toString()),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const LoadingWidget();
//           }
//           return const Login();
//         },
//       ),

// if (snapshot.hasData) {
//               return snapshot.hasData == true
//                   ? const HomeScreen()
//                   : const SignInScreen();
//             }
