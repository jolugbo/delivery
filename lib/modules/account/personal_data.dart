import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/app_text_fields.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                const GoBackButtton(
                  iconColor: AppColor.black,
                  color: AppColor.white,
                  borderColor: AppColor.lightgrey,
                ),
                const SizedBox(width: 80),
                Text(
                  'Personal Data',
                  style:
                      AppTextStyle.body(fontWeight: FontWeight.bold, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Stack(alignment: Alignment.bottomRight, children: [
                Image(image: AssetImage(AppImages.intersect)),
                Image(image: AssetImage(AppImages.frame))
              ]),
            ),
            const SizedBox(height: 30),
            Text(
              'Full Name',
              style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            AppTextFields(controller: nameController, hint: 'Aaron Ramsdale'),
            const SizedBox(height: 15),
            Text(
              'Email',
              style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            AppTextFields(
                controller: nameController, hint: 'aaronramsdale@gmail.com'),
            const SizedBox(height: 15),
            Text(
              'Phone Number',
              style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            AppTextFields(controller: nameController, hint: '(409) 487-8713'),
            const Spacer(),
            AppButton(title: 'Save Changes', onTap: () {}),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
