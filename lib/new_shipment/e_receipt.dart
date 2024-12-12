import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/back_button.dart';

class EReceipt extends StatefulWidget {
  const EReceipt({super.key});

  @override
  State<EReceipt> createState() => _EReceiptState();
}

class _EReceiptState extends State<EReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const GoBackButtton(
                    iconColor: AppColor.black,
                    color: AppColor.white,
                    borderColor: AppColor.lightgrey,
                  ),
                  Text(
                    'E-Receipt',
                    style: AppTextStyle.body(fontWeight: FontWeight.bold),
                  ),
                  Image(image: AssetImage(AppImages.printer))
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Beverly Hills, California',
                          style: AppTextStyle.body(
                              fontWeight: FontWeight.w500, size: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Pickup Location',
                          style: AppTextStyle.body(size: 12),
                        ),
                      ],
                    ),
                  ),
                  Image(image: AssetImage(AppImages.arrow)),
                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          textAlign: TextAlign.end,
                          'Hotel del Coronado, San Diego',
                          style: AppTextStyle.body(
                              fontWeight: FontWeight.w500, size: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Package Destination',
                          style: AppTextStyle.body(size: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.lightgrey)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Receeiver',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              'Aaron Ramsdale',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              '+1(409) 487-1935',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              'aaronramsdale@gmail.com',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              'Aaron Ramsdale',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estimated Delivery Date',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              '10 Oct 2024',
                              style: AppTextStyle.body(
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primaryColor),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.lightgrey)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Methods',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              'Paystack',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trackign ID',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              'FLX198439834',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Method',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              'Express',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFF6E0),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                'In Process',
                                style: AppTextStyle.body(
                                    size: 14,
                                    color: Color(0xffFFBE4C),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.lightgrey)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Package',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              '18,000',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Courier',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              '3,000',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Insurance',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              '8,000',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Destination Duty Fee',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              '5,000',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(height: 25),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: AppTextStyle.body(
                                  size: 14, color: AppColor.grey),
                            ),
                            Text(
                              '34,000',
                              style: AppTextStyle.body(
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primaryColor),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Image(image: AssetImage(AppImages.barcode)),
              Text(
                'FLX652762872',
                style: AppTextStyle.body(size: 14),
              ),
              SizedBox(height: 50),
              AppButton(title: 'Download PDF', onTap: () {}),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
