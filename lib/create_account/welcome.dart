import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image(image: AssetImage(AppImages.welcome)),
              SizedBox(height: 30),
              Text(
                textAlign: TextAlign.center,
                'Welcome to GTDeliveries!',
                style: AppTextStyle.body(size: 33, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Bridging Borders, Delivering Excellence',
                style: AppTextStyle.body(size: 14),
              ),
              SizedBox(height: 80),
              AppButton(title: 'Continue to Home', onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
