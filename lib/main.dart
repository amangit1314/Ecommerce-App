import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/ecommerce.dart';
import 'package:tokoto_ecommerce_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const EcommerceApp());
}
