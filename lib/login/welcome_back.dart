import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/forgot_password/forgot_password.dart';
import 'package:gt_delivery/home/home.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';

class WelcomeBack extends StatefulWidget {
  const WelcomeBack({super.key});

  @override
  State<WelcomeBack> createState() => _WelcomeBackState();
}

class _WelcomeBackState extends State<WelcomeBack> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: 50), Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.black)), child: const Icon(Icons.arrow_back, size: 30),),
          const  SizedBox(height: 25),
            Row(
              children: [
                Text('Welcome Back!', style: AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),), Image(image: AssetImage(AppImages.wave)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Lets get you back on to sending packages', style: AppTextStyle.body(size: 14),),
            const SizedBox(height: 25),
            Text('Email', style: AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
SizedBox(height: 8),
AppTextFields(controller: emailController, hint: 'Enter your email'),
SizedBox(height: 10),
Text('Password', style: AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
SizedBox(height: 8),
AppTextFields(controller: passwordController, hint: 'Enter your password', isPassword: true),
SizedBox(height: 10),
Row(mainAxisAlignment: MainAxisAlignment.end,
  children: [
    GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
    }, child: Text('Forgot Password?', style: AppTextStyle.body(color: AppColor.primaryColor, size: 14, fontWeight: FontWeight.w600),)),
  ],
),
SizedBox(height: 30),
AppButton(title: 'Sign In', onTap: (){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
}),
SizedBox(height: 40),
Row(children: [Expanded(child: Divider()), Text('Or continue with', style: AppTextStyle.body(color: AppColor.grey, size: 14)), Expanded(child: Divider())],),
SizedBox(height: 40),
Container(width: double.infinity,height: 55, decoration: BoxDecoration(border: Border.all(color: AppColor.grey), borderRadius: BorderRadius.circular(40)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Image(image: AssetImage(AppImages.google)), SizedBox(width: 10), Text('Sign in with Google', style: AppTextStyle.body(fontWeight: FontWeight.w600),)],),),
SizedBox(height: 15),
Container(width: double.infinity,height: 55, decoration: BoxDecoration(border: Border.all(color: AppColor.grey), borderRadius: BorderRadius.circular(40)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Image(image: AssetImage(AppImages.apple)), SizedBox(width: 10), Text('Sign in with Apple', style: AppTextStyle.body(fontWeight: FontWeight.w600),)],),),
SizedBox(height: 50),
Row(mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'Already have an account?  ',
                          style: AppTextStyle.body(size: 14), 
                        ),
                        TextSpan(
                            text: 'Sign Up',
                            // recognizer: TapGestureRecognizer()
                            //   ..onTap = () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => ()));
                            //   },
                            style: AppTextStyle.body(
                                fontWeight: FontWeight.bold,
                                size: 15,
                                color: AppColor.primaryColor)),
                      ])),
  ],
),
            ],),
    ),
    ),);
  }
}