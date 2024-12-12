import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/new_shipment/payment_successful.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/back_button.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
              color: AppColor.white,
              borderColor: AppColor.lightgrey,
            ),
            SizedBox(height: 10),
            Text(
              'Payment',
              style: AppTextStyle.body(size: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Select the payment method you want to use to continue',
              style: AppTextStyle.body(size: 14),
            ),
            SizedBox(height: 20),
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
                            style: AppTextStyle.body(size: 14),
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
                            style: AppTextStyle.body(size: 14),
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
                            style: AppTextStyle.body(size: 14),
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
                            style: AppTextStyle.body(size: 14),
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
                            style: AppTextStyle.body(size: 14),
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
            SizedBox(height: 30),
            PaymentWidget(imagePath: AppImages.paystack, title: 'Paystack'),
            SizedBox(height: 15),
            PaymentWidget(
                imagePath: AppImages.flutterwave, title: 'Flutterwave'),
            SizedBox(height: 15),
            PaymentWidget(imagePath: AppImages.paypal, title: 'PayPal'),
            Spacer(),
            AppButton(
                title: 'Make Payment',
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(height: 40),
                                  Image(image: AssetImage(AppImages.boxx)),
                                  SizedBox(height: 40),
                                  Text(
                                    'Price Subject to change',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.bold, size: 25),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Final price will be determined upon inspection of the package at the center, after which the price will be updated.',
                                    style: AppTextStyle.body(size: 15),
                                  ),
                                  Spacer(),
                                  AppButton(
                                      title: 'Continue to payment',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentSuccessful()));
                                      }),
                                  SizedBox(height: 40)
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class PaymentWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  const PaymentWidget({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: const Color.fromARGB(0, 255, 255, 255),
          border: Border.all(color: AppColor.lightgrey),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(width: 20),
          Image(image: AssetImage(imagePath)),
          SizedBox(width: 10),
          Text(
            title,
            style: AppTextStyle.body(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
