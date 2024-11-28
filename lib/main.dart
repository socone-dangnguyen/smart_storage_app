import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/onboarding.dart';
import 'package:smart_storage/widgets/tree_map_responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.white,
      ),
      // home: tree_map_responsive(),
      home: OnboardingScreen(),
    );
  }
}
