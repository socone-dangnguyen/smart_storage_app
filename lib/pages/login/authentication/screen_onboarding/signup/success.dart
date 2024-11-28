import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/styles/spacing_styles.dart';
import 'package:smart_storage/pages/login/utils/constant/image_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/text_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';
import '../login/login.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPhoneScreen = screenHeight / screenWidth > 1.5;

    double containerWidth = isPhoneScreen ? screenWidth : screenWidth / 3;
    double containerHeight = isPhoneScreen ? screenHeight : screenHeight;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          const Positioned.fill(
            child: Image(
              image: AssetImage(AppImages.backGround),
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          Center(
            child: Container(
              width: isPhoneScreen ? double.infinity : containerWidth,
              height: isPhoneScreen ? double.infinity : containerHeight,
              padding: AppSpacingStyles.paddingWithAppBarHeight * 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: isPhoneScreen ? null : BorderRadius.circular(20),
                boxShadow: isPhoneScreen
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // // Image
                  // Image(
                  //   image: const AssetImage(AppImages.staticSuccessIllustration),
                  //   width: AppHelperFunctions.screenWidth() * 0.6,
                  // ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Spacer(),

                  // Title and Subtitle
                  Text(
                    AppTexts.yourAccountCreatedTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Text(
                    AppTexts.yourAccountCreatedSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF000000),
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 0),
                      ),
                      onPressed: () => Get.to(() => const LoginScreen()),
                      child: const Text(AppTexts.appcontinue),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
