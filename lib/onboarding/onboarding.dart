import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/create_account/create_account.dart';
import 'package:gt_delivery/login/welcome_back.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentpage = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (val) {
                      setState(() {
                        currentpage = val;
                      });
                    },
                    children: [
                      // SplashScreenWidget(
                      //     imagePath: AppImages.onboarding1,
                      //     header:
                      //         'Send Packages Locally or Across the Globe with Ease',
                      //     title:
                      //         'Whether local or global, our service makes shipping fast, safe, and easy. Just a few taps, and we’ll handle the rest!'),
                      // SplashScreenWidget(
                      //     imagePath: AppImages.onboarding3,
                      //     header: 'Stay in the Loop with Real-Time Tracking',
                      //     title:
                      //         'Get live updates from pickup to delivery. Our advanced tracking keeps you informed every step of the way, giving you peace of mind.'),
                      // SplashScreenWidget(
                      //     imagePath: AppImages.onboarding1,
                      //     header: 'Reliable and Secure Deliveries',
                      //     title:
                      //         'We prioritize security and reliability. From encryption to careful handling, rest assured your package is in trusted hands, every time.'),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: AppColor.lightgrey,
                      activeDotColor: AppColor.primaryColor),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      AppButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccount()));
                        },
                        title: 'Get Started',
                      ),
                      const SizedBox(height: 5),
                      AppButton(
                        title: 'Login',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeBack()));
                        },
                        borderColor: AppColor.lightgrey,
                        color: AppColor.white,
                        textColor: AppColor.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreenWidget extends StatelessWidget {
  final String imagePath;
  final String header;
  final String title;
  const SplashScreenWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.46,
          child: Image(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 20),
        Text(
          header,
          style: AppTextStyle.body(fontWeight: FontWeight.bold, size: 27),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Text(
          title,
          style: AppTextStyle.body(size: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
