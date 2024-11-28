import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/password_configuration/reset_password.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';
import 'package:smart_storage/pages/login/utils/constant/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Text(AppTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: AppSizes.spaceBtwSections * 2),
            TextFormField(
                decoration: const InputDecoration(
                    labelText: AppTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right))),
            const SizedBox(height: AppSizes.spaceBtwItems),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.off(() => const ResetPassword()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(AppTexts.submit))),
          ],
        ),
      ),
    );
  }
}
