import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_storage/pages/login/utils/constant/image_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/text_strings.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/widgets/onboarding_next_button.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/widgets/onboarding_page.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/widgets/onboarding_skip.dart';
import 'package:smart_storage/pages/login/authentication/controllers_onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AppImages.onBoardingImage1,
                title: AppTexts.onBoardingTitle1,
                subTitle: AppTexts.onBoardingSubTitle1,
                backgroundImage: '',
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage2,
                title: AppTexts.onBoardingTitle2,
                subTitle: AppTexts.onBoardingSubTitle2,
                backgroundImage: '',
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage3,
                title: AppTexts.onBoardingTitle3,
                subTitle: AppTexts.onBoardingSubTitle3,
                backgroundImage: '',
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
