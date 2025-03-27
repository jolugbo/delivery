import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/app_text_fields.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';

class Number extends StatefulWidget {
  const Number({super.key});

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
  final TextEditingController emailController = TextEditingController();
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
              'Enter the phone number linked to your account and we will send you a code to change your password',
              style: AppTextStyle.body(size: 14),
            ),
            const SizedBox(height: 25),
            Text('Phone Number',
                style:
                    AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            AppTextFields(
                controller: emailController, hint: 'Enter your phone number'),
            const SizedBox(height: 50),
            AppButton(
                title: 'Send Code',
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerificationCode()));
                }),
          ],
        ),
      ),
    );
  }
}
