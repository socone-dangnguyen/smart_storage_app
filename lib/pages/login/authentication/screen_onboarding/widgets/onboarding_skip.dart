import 'package:flutter/material.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';
import '../../../utils/device/device_utility.dart';
import 'package:smart_storage/pages/login/authentication/controllers_onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: AppDeviceUtils.getAppBarHeight(),
        right: AppSizes.defaultSpace,
        child: TextButton(
          onPressed: () => OnboardingController.instance.skipPage(),
          child: const Text('Skip'),
        ));
  }
}
