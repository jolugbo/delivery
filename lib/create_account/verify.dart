import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/create_account/verification_code.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/item_button.dart';
import 'package:gt_delivery/widget/loading.dart';
import 'package:provider/provider.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  final String phone;
  final String userId;
  const VerifyPage(
      {super.key,
      required this.email,
      required this.userId,
      required this.phone});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  String? channel;
  bool isLoarding = false;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: isLoarding
          ? Loading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.black)),
                    child: const Icon(Icons.arrow_back, size: 30),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Verify Your Account',
                    style: AppTextStyle.body(
                        size: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To verify the account you just created, select a amethod below.',
                    style: AppTextStyle.body(size: 14),
                  ),
                  const SizedBox(height: 25),
                  ItemButton(
                      imagePath: AppImages.mail,
                      title: 'Email',
                      subtitle: "To verify via email",
                      isActive: channel == "EMAIL",
                      onTap: () {
                        setState(() {
                          channel = "EMAIL";
                        });
                      }),
                  SizedBox(height: 25),
                  ItemButton(
                      imagePath: AppImages.mail,
                      title: 'SMS',
                      subtitle: 'To verify via Phone number',
                      isActive: channel == "SMS",
                      onTap: () {
                        setState(() {
                          channel = "SMS";
                        });
                      }),
                  SizedBox(height: 50),
                  AppButton(
                      title: 'Next',
                      color: channel == null
                          ? AppColor.grey
                          : AppColor.primaryColor,
                      onTap: () async {
                        if (channel == null) {
                          return;
                        }
                        setState(() {
                          isLoarding = true;
                        });

                        var response =
                            await authProvider.requestConfirmationToken(
                                emailOrPhone: channel == "SMS"
                                    ? widget.phone
                                    : widget.email,
                                confirmationTokenType: channel!,
                                userId: widget.userId);

                        setState(() {
                          isLoarding = false;
                        });

                        if (response['success']) {
                          log("Signup successful: ${response['data']} ${response["data"]["resultData"]["id"]}");
                          log("${response["data"]["resultData"]["id"]}");
                          // Navigate to another screen or show success message

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerificationCode(
                                        channel: channel!,
                                        emailOrPhone: channel == "SMS"
                                            ? widget.phone
                                            : widget.email,
                                        userId: widget.userId,
                                      )));
                        } else {
                          print("Signup failed: ${response['message']}");
                          CustomSnackbar.showError(
                              context, "Error sending Email");
                          // Show error message
                        }
                      }),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By registering you agree to \n',
                          style:
                              AppTextStyle.body(color: AppColor.grey, size: 14),
                          children: [
                            TextSpan(
                              text: 'Terms &  Conditions ',
                              style: AppTextStyle.body(
                                  color: AppColor.primaryColor,
                                  size: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                                text: 'and ',
                                style: AppTextStyle.body(
                                    color: AppColor.grey, size: 14)),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppTextStyle.body(
                                  color: AppColor.primaryColor,
                                  size: 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ),
    );
  }
}
