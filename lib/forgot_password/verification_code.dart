import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/forgot_password/set_new_password.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ForgotPasswordVerificationCode extends StatefulWidget {
  const ForgotPasswordVerificationCode({super.key});

  @override
  State<ForgotPasswordVerificationCode> createState() => _ForgotPasswordVerificationCodeState();
}

class _ForgotPasswordVerificationCodeState extends State<ForgotPasswordVerificationCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: 50),
         Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.black)), child: const Icon(Icons.arrow_back, size: 30),),
            const  SizedBox(height: 25),
              Text('Verification Code', style: AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),),
              const SizedBox(height: 8),
              Text('Enter the 6-digit code we sent to gtuser@gmail.com', style: AppTextStyle.body(size: 14),),
              const SizedBox(height: 25),
              PinCodeTextField(
                pinTextStyle: AppTextStyle.body(),
                keyboardType: TextInputType.number,
                maxLength: 6,     
                pinBoxRadius: 10,     
                pinBoxColor: const Color.fromARGB(13, 255, 255, 255),   
                pinBoxWidth: 55,
                pinBoxHeight: 60,  
                defaultBorderColor: AppColor.lightgrey,
                hasTextBorderColor: AppColor.primaryColor,
              ),
              SizedBox(height: 20),
               Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'You can resend the code in 56 seconds ',
                      style: AppTextStyle.body(size: 14), 
                    ),
                    TextSpan(
                        text: 'Resend Code',
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => ()));
                        //   },
                        style: AppTextStyle.body(
                            fontWeight: FontWeight.bold,
                            size: 14,
                            color: AppColor.primaryColor)),
                  ])),
                                SizedBox(height: 40),
                                AppButton(title: 'Verify', onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SetNewPassword()));
                                }),

      ],),
    ),);
  }
}