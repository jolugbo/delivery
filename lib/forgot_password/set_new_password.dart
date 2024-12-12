import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/forgot_password/verification_code.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ const SizedBox(height: 50),
            Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.black)), child: const Icon(Icons.arrow_back, size: 30),),
          const  SizedBox(height: 25),
            Text('Set new Password', style: AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),),
            const SizedBox(height: 8),
            Text('Create a new 8 digit password', style: AppTextStyle.body(size: 14),),
            const SizedBox(height: 25),
            Text('Password', style: AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
SizedBox(height: 8),
AppTextFields(controller: passwordController, hint: 'Enter your password', isPassword: true,),
SizedBox(height: 10),
 Text('Confirm Password', style: AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
SizedBox(height: 8),
AppTextFields(controller: confirmPasswordController, hint: 'Enter your password', isPassword: true,),
            SizedBox(height: 50),
            AppButton(title: 'Set New Password', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerificationCode()));
            }),            
            ],),
    ),);
  }
}