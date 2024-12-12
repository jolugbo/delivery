import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/back_button.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                const GoBackButtton(
                  iconColor: AppColor.black,
                  color: AppColor.white,
                  borderColor: AppColor.lightgrey,
                ),
                SizedBox(width: 100),
                Text(
                  'About App',
                  style:
                      AppTextStyle.body(fontWeight: FontWeight.bold, size: 20),
                ),
              ],
            ),
            SizedBox(height: 50),
            Center(child: Image(image: AssetImage(AppImages.logoversion))),
            SizedBox(height: 50),
            AboutWidget(title: 'Developer'),
            SizedBox(height: 15),
            AboutWidget(title: 'Partner'),
            SizedBox(height: 15),
            AboutWidget(title: 'Accessibility'),
            SizedBox(height: 15),
            AboutWidget(title: 'Terms of Use'),
            SizedBox(height: 15),
            AboutWidget(title: 'Feedback'),
            SizedBox(height: 15),
            AboutWidget(title: 'Rate us'),
            SizedBox(height: 15),
            AboutWidget(title: 'Visit Our Website'),
            SizedBox(height: 15),
            AboutWidget(title: 'Follow us On Social Media'),
          ],
        ),
      ),
    );
  }
}

class AboutWidget extends StatelessWidget {
  final String title;
  const AboutWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Text(title,
              style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500)),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 18, color: AppColor.grey),
        ],
      ),
    );
  }
}
