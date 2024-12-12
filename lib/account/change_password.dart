import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';
import 'package:gt_delivery/widget/back_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
              Row(
                children: [
                  const GoBackButtton(
                    iconColor: AppColor.black,
                    color: AppColor.white,
                    borderColor: AppColor.lightgrey,
                  ),
                  SizedBox(width: 80),
                  Text(
                    'Change Password',
                    style: AppTextStyle.body(
                        fontWeight: FontWeight.bold, size: 20),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                'Old Password',
                style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              AppTextFields(
                  isPassword: true,
                  controller: oldPasswordController,
                  hint: 'input your old password'),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 20),
              Text(
                'New Password',
                style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              AppTextFields(
                  isPassword: true,
                  controller: newPasswordController,
                  hint: 'input your new password'),
              SizedBox(height: 20),
              Text(
                'Confirm New Password',
                style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              AppTextFields(
                  isPassword: true,
                  controller: newPasswordController,
                  hint: 'confirm your new password'),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: AppTextStyle.body(
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
