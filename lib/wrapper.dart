import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/resources/services/auth/auth_service.dart';
import 'package:soni_store_app/screens/home/home_screen.dart';
import 'package:soni_store_app/screens/splash/splash_screen.dart';

import 'models/models.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;

          return user == null ? const SplashScreen() : const HomeScreen();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
