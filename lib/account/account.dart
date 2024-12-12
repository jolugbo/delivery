import 'package:flutter/material.dart';
import 'package:gt_delivery/account/about.dart';
import 'package:gt_delivery/account/help_center.dart';
import 'package:gt_delivery/account/personal_data.dart';
import 'package:gt_delivery/account/privacy_policy.dart';
import 'package:gt_delivery/account/security.dart';
import 'package:gt_delivery/account/terms_and_condition.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  'My Account',
                  style:
                      AppTextStyle.body(fontWeight: FontWeight.bold, size: 22),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Image(image: AssetImage(AppImages.profilepicture)),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aaron Ramsdale',
                          style: AppTextStyle.body(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white),
                        ),
                        Text(
                          'aaronramsdale@gmail.com',
                          style: AppTextStyle.body(
                              color: AppColor.white, size: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Personal  Info',
                style: AppTextStyle.body(
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey),
              ),
              SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PersonalData()));
                },
                imagePath: AppImages.user,
                title: 'Personal Data',
              ),
              SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Security()));
                },
                imagePath: AppImages.shieldbolt,
                title: 'Account Security',
              ),
              SizedBox(height: 30),
              Text(
                'General',
                style: AppTextStyle.body(
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey),
              ),
              SizedBox(height: 15),
              AccountWidget(
                onTap: () {},
                imagePath: AppImages.worldb,
                title: 'Language',
              ),
              SizedBox(height: 30),
              Text(
                'About',
                style: AppTextStyle.body(
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey),
              ),
              SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HelpCenter()));
                },
                imagePath: AppImages.help,
                title: 'Help Center',
              ),
              SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
                imagePath: AppImages.lockb,
                title: 'Privacy & Policy',
              ),
              SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
                imagePath: AppImages.infocircle,
                title: 'About App',
              ),
              SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndCondition()));
                },
                imagePath: AppImages.gavel,
                title: 'Terms & Condition',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  const AccountWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image(image: AssetImage(imagePath)),
          SizedBox(width: 10),
          Text(title,
              style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500)),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 18, color: AppColor.grey),
        ],
      ),
    );
  }
}
