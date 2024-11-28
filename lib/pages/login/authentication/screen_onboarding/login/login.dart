import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_storage/pages/login/common/styles/spacing_styles.dart';
import 'package:smart_storage/pages/login/utils/constant/colors.dart';
import 'package:smart_storage/pages/login/utils/constant/image_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/text_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';
import 'package:smart_storage/pages/login/utils/helpers/helper_function.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/password_configuration/forget_password.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/signup/signup.dart';
import 'package:smart_storage/widgets/tree_map_responsive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Determine if it's a phone or laptop layout
    final bool isPhoneScreen = screenHeight / screenWidth > 1.5;

    // Container width and height based on screen type
    double containerWidth = isPhoneScreen ? screenWidth : screenWidth / 3;
    double containerHeight = isPhoneScreen ? screenHeight : screenHeight;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          const Positioned.fill(
            child: Image(
              image: AssetImage(AppImages.backGround),
              fit: BoxFit.cover, // Ảnh phủ kín màn hình và giữ tỉ lệ
            ),
          ),

          // Main content with form and buttons
          Center(
            child: Container(
              width: isPhoneScreen ? double.infinity : containerWidth,
              height: isPhoneScreen ? double.infinity : containerHeight,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1), // Nền trắng mờ cho nội dung
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
              child: SingleChildScrollView(
                padding: AppSpacingStyles.paddingWithAppBarHeight,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image(
                            height: 150,
                            image: AssetImage(dark
                                ? AppImages.darkAppLogo
                                : AppImages.darkAppLogo),
                          ),
                        ),
                        Text(AppTexts.loginTitle,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: AppSizes.sm),
                        Text(AppTexts.loginSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.spaceBtwSections),
                        child: Column(
                          children: [
                            // Email
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.direct_right,
                                    color: Color(0xFF000000)),
                                labelText: AppTexts.email,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: AppSizes.spaceBtwInputFields),
                            // Password
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.password_check,
                                    color: Color(0xFF000000)),
                                labelText: AppTexts.password,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                suffixIcon: Icon(Iconsax.eye_slash,
                                    color: Color(0xFF000000)),
                              ),
                            ),
                            const SizedBox(
                                height: AppSizes.spaceBtwInputFields / 2),

                            // Remember Me and Forget Password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: true,
                                        onChanged: (value) {},
                                        activeColor: const Color(0xFF000000)),
                                    const Text(AppTexts.rememberMe),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Get.to(() => const ForgetPassword()),
                                  child: const Text(AppTexts.forgetPassword),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.spaceBtwSections),

                            // Sign In Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF000000),
                                  foregroundColor: Colors.black,
                                  side: const BorderSide(
                                      color: Colors.white, width: 0),
                                ),
                                onPressed: () {
                                  Get.offAll(() => tree_map_responsive());
                                },
                                child: const Text(AppTexts.signIn,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwItems),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Color(0xFF000000), width: 1),
                                ),
                                onPressed: () =>
                                    Get.to(() => const SignupScreen()),
                                child: const Text(AppTexts.createAccount),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Divider and social icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Divider(
                            color: dark ? AppColors.darkGrey : AppColors.grey,
                            thickness: 0.5,
                            indent: 60,
                            endIndent: 5,
                          ),
                        ),
                        Text(AppTexts.orSignInWith.capitalize!,
                            style: Theme.of(context).textTheme.labelMedium),
                        Flexible(
                          child: Divider(
                            color: dark ? AppColors.darkGrey : AppColors.grey,
                            thickness: 0.5,
                            indent: 6,
                            endIndent: 60,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),

                    // Social Media Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              width: AppSizes.iconMd,
                              height: AppSizes.iconMd,
                              image: AssetImage(AppImages.google),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.spaceBtwItems),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              width: AppSizes.iconMd,
                              height: AppSizes.iconMd,
                              image: AssetImage(AppImages.facebook),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
