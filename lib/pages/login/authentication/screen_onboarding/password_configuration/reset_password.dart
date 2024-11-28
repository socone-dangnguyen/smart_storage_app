import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_storage/pages/login/utils/constant/image_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';
import 'package:smart_storage/pages/login/utils/constant/text_strings.dart';
import 'package:smart_storage/pages/login/utils/helpers/helper_function.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                  image: const AssetImage(AppImages.deliveredEmailIllustration),
                  width: AppHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Title and Subtitle
              Text(AppTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(AppTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF000000),
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.white, width: 0)),
                      onPressed: () {},
                      child: const Text(AppTexts.done,
                          style: TextStyle(color: Colors.white)))),
              const SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(AppTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
