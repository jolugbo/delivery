import 'package:flutter/material.dart';
import 'package:gt_delivery/modules/account/about.dart';
import 'package:gt_delivery/modules/account/help_center.dart';
import 'package:gt_delivery/modules/account/personal_data.dart';
import 'package:gt_delivery/modules/account/privacy_policy.dart';
import 'package:gt_delivery/modules/account/security.dart';
import 'package:gt_delivery/modules/account/terms_and_condition.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';

class Account extends StatefulWidget {
  final token;
  final userProfile;
  const Account({super.key, required this.token, required this.userProfile});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override String username = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadData(); 
  }

  // Function to load data from secure storage
  Future<void> _loadData() async {
    // final Encryptor secureStorageService = Encryptor();
    // String? userName = await secureStorageService.getData('username');
    // //String? userName = await _secureStorageService.getData("userName");
    // //String? id = await _secureStorageService.getData('id');
    // print("value of data is  ${widget.userId}");
    // setState(() {
    //   username = widget.userId ?? "Loading...";
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'My Account',
                  style:
                      AppTextStyle.body(fontWeight: FontWeight.bold, size: 22),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Image(image: AssetImage(AppImages.profilepicture)),
                    const SizedBox(width: 20),
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
              const SizedBox(height: 30),
              Text(
                'Personal  Info',
                style: AppTextStyle.body(
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey),
              ),
              const SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PersonalData()));
                },
                imagePath: AppImages.user,
                title: 'Personal Data',
              ),
              const SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Security()));
                },
                imagePath: AppImages.shieldbolt,
                title: 'Account Security',
              ),
              const SizedBox(height: 30),
              Text(
                'General',
                style: AppTextStyle.body(
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey),
              ),
              const SizedBox(height: 15),
              AccountWidget(
                onTap: () {},
                imagePath: AppImages.worldb,
                title: 'Language',
              ),
              const SizedBox(height: 30),
              Text(
                'About',
                style: AppTextStyle.body(
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey),
              ),
              const SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HelpCenter()));
                },
                imagePath: AppImages.help,
                title: 'Help Center',
              ),
              const SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
                },
                imagePath: AppImages.lockb,
                title: 'Privacy & Policy',
              ),
              const SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const About()));
                },
                imagePath: AppImages.infocircle,
                title: 'About App',
              ),
              const SizedBox(height: 15),
              AccountWidget(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsAndCondition()));
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
          const SizedBox(width: 10),
          Text(title,
              style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 18, color: AppColor.grey),
        ],
      ),
    );
  }
}
