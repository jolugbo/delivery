import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/modules/forgot_password/email.dart';
import 'package:gt_delivery/modules/forgot_password/number.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:gt_delivery/utils/widget/item_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? channel;

  void redirectToToken() {
    if (channel == null) {
      CustomSnackbar.showError(context, "Please Select Verification Method");
      return;
    }
    if (channel == "EMAIL") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Email()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Number()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              'Forgot Password',
              style: AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a method below and we will send you a code to change your password',
              style: AppTextStyle.body(size: 14),
            ),
            const SizedBox(height: 25),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => Email()));
            //   },
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     height: 85,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: AppColor.grey),
            //         borderRadius: BorderRadius.circular(10)),
            //     child: Row(
            //       children: [
            //         SizedBox(width: 20),
            //         Container(
            //           height: 40,
            //           width: 40,
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: const Color(0xffFEECED)),
            //           child: Image(image: AssetImage(AppImages.mail)),
            //         ),
            //         SizedBox(width: 15),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             SizedBox(height: 15),
            //             Text(
            //               'Email',
            //               style: AppTextStyle.body(fontWeight: FontWeight.w500),
            //             ),
            //             Text(
            //               'To verify via email',
            //               style:
            //                   AppTextStyle.body(size: 14, color: AppColor.grey),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
           
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
            const SizedBox(height: 15),
            ItemButton(
                imagePath: AppImages.mail,
                title: 'SMS',
                subtitle: "To verify via Phone number",
                isActive: channel == "SMS",
                onTap: () {
                  setState(() {
                    channel = "SMS";
                  });
                }),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => Number()));
            //   },
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     height: 85,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: AppColor.grey),
            //         borderRadius: BorderRadius.circular(10)),
            //     child: Row(
            //       children: [
            //         SizedBox(width: 20),
            //         Container(
            //           height: 40,
            //           width: 40,
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: const Color(0xffFEECED)),
            //           child: Image(image: AssetImage(AppImages.vector)),
            //         ),
            //         SizedBox(width: 15),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             SizedBox(height: 15),
            //             Text(
            //               'SMS',
            //               style: AppTextStyle.body(fontWeight: FontWeight.w500),
            //             ),
            //             Text(
            //               'To verify via Phone number',
            //               style:
            //                   AppTextStyle.body(size: 14, color: AppColor.grey),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 50),
            AppButton(
                title: 'Next',
                color: channel == null ? AppColor.grey : AppColor.primaryColor,
                onTap: () => redirectToToken()),
          ],
        ),
      ),
    );
  }
}
