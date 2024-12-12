import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/forgot_password/verification_code.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ const SizedBox(height: 50),
            Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.black)), child: const Icon(Icons.arrow_back, size: 30),),
          const  SizedBox(height: 25),
            Text('Forgot Password', style: AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),),
            const SizedBox(height: 8),
            Text('Enter the email linked to your account and we will send you a code to change your password', style: AppTextStyle.body(size: 14),),
            const SizedBox(height: 25),
            Text('Email', style: AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
SizedBox(height: 8),
AppTextFields(controller: emailController, hint: 'Enter your email'),
            SizedBox(height: 50),
            AppButton(title: 'Send Code', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerificationCode()));
            }),            
            ],),
    ),);
  }
}