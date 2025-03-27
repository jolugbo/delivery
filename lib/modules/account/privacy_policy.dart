import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
              Row(
                children: [
                  const GoBackButtton(
                    iconColor: AppColor.black,
                    color: AppColor.white,
                    borderColor: AppColor.lightgrey,
                  ),
                  const SizedBox(width: 80),
                  Text(
                    'Privacy Policy',
                    style: AppTextStyle.body(
                        fontWeight: FontWeight.bold, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Effective Date: March 20, 2024',
                style: AppTextStyle.body(fontWeight: FontWeight.w500, size: 16),
              ),
              const SizedBox(height: 20),
              Text(
                '1. Information Collection',
                style: AppTextStyle.body(fontWeight: FontWeight.w500, size: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.',
                style: AppTextStyle.body(size: 15, color: AppColor.grey),
              ),
              const SizedBox(height: 20),
              Text(
                '2. Information Usage',
                style: AppTextStyle.body(fontWeight: FontWeight.w500, size: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.',
                style: AppTextStyle.body(size: 15, color: AppColor.grey),
              ),
              const SizedBox(height: 20),
              Text(
                '3. Information Setting',
                style: AppTextStyle.body(fontWeight: FontWeight.w500, size: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.',
                style: AppTextStyle.body(size: 15, color: AppColor.grey),
              ),
              const SizedBox(height: 20),
              Text(
                '4. Security Measures',
                style: AppTextStyle.body(fontWeight: FontWeight.w500, size: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Faucibus viverra ante amet elementum pretium. Sapien id lobortis venenatis phasellus laoreet. Pulvinar pharetra magna vel augue. Massa parturient nisl tempor fringilla.',
                style: AppTextStyle.body(size: 15, color: AppColor.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
