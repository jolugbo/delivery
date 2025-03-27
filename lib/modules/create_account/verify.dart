import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/modules/create_account/verification_code.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:gt_delivery/utils/widget/item_button.dart';
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
  bool isLoading = false;

  Future<void> requestToken(AuthProvider authProvider) async {
    if (channel == null) {
      CustomSnackbar.showError(context, "Please Select Verification Method");
      return;
    }
    setState(() {
      isLoading = true;
    });

    var response = await authProvider.requestConfirmationToken(
        emailOrPhone: channel == "SMS" ? widget.phone : widget.email,
        confirmationTokenType: channel!,
        userId: widget.userId);

    setState(() {
      isLoading = false;
    });

    if (response['success']) {
      print("Signup successful: ${response['data']} ${response["data"]["resultData"]["id"]}");
      print("${response["data"]["resultData"]["id"]}");
      log("${response["data"]["resultData"]["id"]}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationCode(
                    channel: channel!,
                    emailOrPhone:
                        channel == "SMS" ? widget.phone : widget.email,
                    userId: widget.userId,
                  )));
    } else {
      print("Signup failed: ${response['message']}");
      CustomSnackbar.showError(context, "Error sending $channel");
      // Show error message
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        body: Stack(
            //overflow: Overflow.visible,
            children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                
                  const GoBackButtton(
                    iconColor: AppColor.black,
                  ),
                const SizedBox(height: 25),
                Text(
                  'Verify Your Account',
                  style:
                      AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'To verify the account you just created, select a method below.',
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
                const SizedBox(height: 25),
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
                const SizedBox(height: 50),
                AppButton(
                    title: 'Next',
                    color:
                        channel == null ? AppColor.grey : AppColor.primaryColor,
                    onTap: () => requestToken(authProvider)),
                const Spacer(),
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
                const SizedBox(height: 40)
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
        ]));
  }
}
