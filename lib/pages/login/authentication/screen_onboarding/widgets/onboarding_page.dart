import 'package:flutter/material.dart';
import 'package:smart_storage/pages/login/utils/constant/image_strings.dart';
import 'package:smart_storage/pages/login/utils/constant/sizes.dart';

enum ScreenType { phone, laptop }

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.backgroundImage,
  });

  final String image, title, subTitle, backgroundImage;

  // Function to determine screen type based on aspect ratio
  ScreenType getScreenType(double screenWidth, double screenHeight) {
    return (screenHeight / screenWidth > 1.5)
        ? ScreenType.phone
        : ScreenType.laptop;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final ScreenType screenType = getScreenType(screenWidth, screenHeight);

    // Calculate container size based on device type
    double containerWidth, containerHeight;
    switch (screenType) {
      case ScreenType.phone:
        containerWidth = screenWidth * 0.9;
        containerHeight = containerWidth * (16 / 9); // Aspect ratio 9:16
        break;
      case ScreenType.laptop:
        containerWidth = screenWidth / 3;
        containerHeight = screenHeight; // Full height for laptop view
        break;
    }

    return Container(
      color: Colors.grey[200], // Light gray background for the whole screen
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Image
          const Positioned.fill(
            child: Image(
              image: AssetImage(AppImages.backGround),
              fit: BoxFit.cover, // Sử dụng BoxFit.cover để ảnh phủ kín màn hình
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Colors.white, // White background for main content
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5), // Light shadow effect
                    ),
                  ],
                ),
                // padding: const EdgeInsets.all(AppSizes.defaultSpace),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: screenType == ScreenType.phone
                          ? containerWidth * 0.9
                          : containerWidth * 0.9,
                      height: screenType == ScreenType.phone
                          ? containerHeight * 0.6
                          : containerHeight * 0.7,
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    Text(
                      subTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
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
