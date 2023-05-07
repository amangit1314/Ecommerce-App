import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/ecommerce.dart';
import 'package:soni_store_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const

    const EcommerceApp(), // Wrap your app
    // ),
  );
}
