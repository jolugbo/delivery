import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/create_account/welcome.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';

class SecurityQuestion extends StatefulWidget {
  const SecurityQuestion({super.key});

  @override
  State<SecurityQuestion> createState() => _SecurityQuestionState();
}

class _SecurityQuestionState extends State<SecurityQuestion> {
  TextEditingController answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: 50), Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.black)), child: const Icon(Icons.arrow_back, size: 30),),
              const  SizedBox(height: 25),
                Text('Security Question', style: AppTextStyle.body(size: 27, fontWeight: FontWeight.bold),),
                const SizedBox(height: 8),
                Text('Set a security question and answer', style: AppTextStyle.body(size: 14, color: AppColor.grey),),
                const SizedBox(height: 25),
                 Text('Security Question', style: AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                 DropdownButtonFormField<String>(hint: Text('Select Question', style: AppTextStyle.body(size: 14),), decoration: InputDecoration(border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ))),
  items: <String>['Question1', 'Question2'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value, style: AppTextStyle.body(size: 14),),
    );
  }).toList(),
  onChanged: (_) {},
),
                SizedBox(height: 10),
                Text('Answer', style: AppTextStyle.body(size: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                AppTextFields(controller: answerController, hint: 'Answer to Security Question'),
                SizedBox(height: 40),
                AppButton(title: 'Set Question', onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
                }),
                ]),
    ),);
  }
}