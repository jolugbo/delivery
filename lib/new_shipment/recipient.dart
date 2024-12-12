import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/new_shipment/package_details.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';
import 'package:gt_delivery/widget/back_button.dart';

class Recipient extends StatefulWidget {
  const Recipient({super.key});

  @override
  State<Recipient> createState() => _RecipientState();
}

class _RecipientState extends State<Recipient> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 5),
                      GoBackButtton(),
                      Text(
                        'International Shipment',
                        style: AppTextStyle.body(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            size: 22),
                      ),
                      Text(
                        'Terms',
                        style: AppTextStyle.body(
                            Decoration: TextDecoration.underline,
                            size: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white),
                      ),
                      SizedBox(width: 5)
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Text(
                        'Recipient Details',
                        style: AppTextStyle.body(
                            fontWeight: FontWeight.w500, color: AppColor.white),
                      ),
                      Spacer(),
                      Text(
                        '3/6 Step',
                        style:
                            AppTextStyle.body(size: 16, color: AppColor.white),
                      ),
                      SizedBox(width: 20)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'Destination Country',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    hint: Text(
                      'Choose City/Province',
                      style: AppTextStyle.body(size: 14),
                    ),
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.3)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.primaryColor)),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ))),
                    items: <String>[
                      'Los Angeles, United States',
                      'Chicago, United States'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppTextStyle.body(size: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Receiver Information',
                    style: AppTextStyle.body(
                        fontWeight: FontWeight.bold, color: AppColor.grey),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Receiver Name',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  AppTextFields(controller: nameController, hint: 'Input Name'),
                  SizedBox(height: 10),
                  Text(
                    'Phone Number',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  AppTextFields(
                      controller: numberController, hint: 'Input Phone Number'),
                  SizedBox(height: 10),
                  Text(
                    'Email',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  AppTextFields(
                      controller: emailController, hint: 'Input your email'),
                  SizedBox(height: 10),
                  Text(
                    'Post Code',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  AppTextFields(
                      controller: addressController, hint: 'Input Post Code'),
                  SizedBox(height: 10),
                  Text(
                    'City/Province',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    hint: Text(
                      'Choose City/Province',
                      style: AppTextStyle.body(size: 14),
                    ),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.3)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.primaryColor)),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ))),
                    items: <String>[
                      'Los Angeles, United States',
                      'Chicago, United States'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppTextStyle.body(size: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Apartment / House No.',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  AppTextFields(
                      controller: addressController,
                      hint: 'Input apartment no'),
                  SizedBox(height: 10),
                  Text(
                    'Address Details',
                    style: AppTextStyle.body(size: 14),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    maxLines: 5,
                    maxLength: 200,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.3)),
                        border: OutlineInputBorder(),
                        hintText: 'Enter address',
                        hintStyle: AppTextStyle.body(size: 13)),
                  ),
                  SizedBox(height: 50),
                  AppButton(
                      title: 'Next',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PackageDetails()));
                      }),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
