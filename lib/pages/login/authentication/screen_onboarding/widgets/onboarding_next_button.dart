import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_storage/pages/login/utils/constant/colors.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';
import 'package:smart_storage/pages/login/authentication/controllers_onboarding/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Align(
      alignment: isPortrait ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(
          right: AppSizes.defaultSpace,
          bottom: AppSizes.defaultSpace,
        ),
        child: ElevatedButton(
          onPressed: () => OnboardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.all(isPortrait ? 16 : 24),
          ),
          child: Icon(
            Iconsax.arrow_right_3,
            size: isPortrait ? 24 : 32,
          ),
        ),
      ),
    );
  }
}
