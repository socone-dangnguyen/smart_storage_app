import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smart_storage/pages/login/utils/constant/colors.dart';
import 'package:smart_storage/pages/login/authentication/controllers_onboarding/onboarding_controller.dart';
import 'onboarding_page.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  ScreenType getScreenType(double screenWidth, double screenHeight) {
    return (screenHeight / screenWidth > 1.5)
        ? ScreenType.phone
        : ScreenType.laptop;
  }

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Tính chiều rộng của indicator dựa trên số lượng chấm và khoảng cách giữa các chấm
    const double dotCount = 3;
    const double dotSize = 6;
    const double spacing = 8;
    final double indicatorWidth = dotCount * dotSize + (dotCount - 1) * spacing;

    return Positioned(
      left: (screenWidth - indicatorWidth) / 2, // Căn giữa trục hoành
      bottom: screenHeight * 0.05, // Giữ nguyên trục tung
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: const ExpandingDotsEffect(
          activeDotColor: AppColors.primary,
          dotHeight: dotSize,
          dotWidth: dotSize,
          spacing: spacing, // Khoảng cách giữa các chấm
        ),
      ),
    );
  }
}
