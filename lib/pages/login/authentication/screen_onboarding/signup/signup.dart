import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/signup/verify_email.dart';
import 'package:smart_storage/pages/login/utils/constant/colors.dart';
import 'package:smart_storage/pages/login/utils/constant/image_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';
import 'package:smart_storage/pages/login/utils/constant/text_strings.dart';
import 'package:smart_storage/pages/login/utils/helpers/helper_function.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

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

          // Main content with form and buttons
          Center(
            child: Container(
              width: isPhoneScreen ? double.infinity : containerWidth,
              height: isPhoneScreen ? double.infinity : containerHeight,
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppTexts.signupTitle,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: AppSizes.spaceBtwSections),

                    // Form
                    Form(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // First Name
                              Expanded(
                                child: TextFormField(
                                  expands: false,
                                  decoration: const InputDecoration(
                                    labelText: AppTexts.firstName,
                                    prefixIcon: Icon(Iconsax.user),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: AppSizes.spaceBtwInputFields),
                              // Last Name
                              Expanded(
                                child: TextFormField(
                                  expands: false,
                                  decoration: const InputDecoration(
                                    labelText: AppTexts.lastName,
                                    prefixIcon:
                                        Icon(Icons.supervised_user_circle),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),

                          // Username
                          TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                              labelText: AppTexts.username,
                              prefixIcon: Icon(Iconsax.user_edit),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),

                          // Email
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: AppTexts.email,
                              prefixIcon: Icon(Iconsax.direct),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),

                          // Phone Number
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: AppTexts.phoneNo,
                              prefixIcon: Icon(Iconsax.call),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),

                          // Password
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: AppTexts.password,
                              prefixIcon: Icon(Iconsax.password_check),
                              suffixIcon: Icon(Iconsax.eye_slash),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwSections),

                          // Privacy and terms
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: true,
                                  onChanged: (value) {},
                                  activeColor: const Color(0xFF000000),
                                ),
                              ),
                              const SizedBox(width: AppSizes.spaceBtwItems),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppTexts.iAgreeTo,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    TextSpan(
                                      text: AppTexts.privacyPolicy,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .apply(
                                            color: dark
                                                ? AppColors.white
                                                : AppColors.primary,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                    TextSpan(
                                      text: AppTexts.and,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    TextSpan(
                                      text: AppTexts.termsOfUse,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .apply(
                                            color: dark
                                                ? AppColors.white
                                                : AppColors.primary,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceBtwSections),

                          // Sign Up Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF000000),
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.white, width: 0),
                              ),
                              onPressed: () =>
                                  Get.to(() => const VerifyEmailScreen()),
                              child: const Text(AppTexts.createAccount),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),

                    // Divider
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
