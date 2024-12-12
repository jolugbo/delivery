import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/new_shipment/price_estimate.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/back_button.dart';
import 'package:gt_delivery/widget/item_button.dart';

class Courier extends StatefulWidget {
  const Courier({super.key});

  @override
  State<Courier> createState() => _CourierState();
}

class _CourierState extends State<Courier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      'Courier',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.w500, color: AppColor.white),
                    ),
                    Spacer(),
                    Text(
                      '5/6 Step',
                      style: AppTextStyle.body(size: 16, color: AppColor.white),
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
              children: [
                SizedBox(height: 20),
                ItemButton(
                    imagePath: AppImages.bike,
                    title: 'Bicycle',
                    subtitle: '12 mins away',
                    onTap: () {}),
                SizedBox(height: 10),
                ItemButton(
                    imagePath: AppImages.motorbike,
                    title: 'Bike',
                    subtitle: '12 mins away',
                    onTap: () {}),
                SizedBox(height: 10),
                ItemButton(
                    imagePath: AppImages.car,
                    title: 'Car',
                    subtitle: '12 mins away',
                    onTap: () {}),
                SizedBox(height: 10),
                ItemButton(
                    imagePath: AppImages.van,
                    title: 'Van',
                    subtitle: '85 mins away',
                    onTap: () {}),
                SizedBox(height: 10),
                ItemButton(
                    imagePath: AppImages.truck,
                    title: 'Truck',
                    subtitle: '22 mins away',
                    onTap: () {}),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppButton(
                title: 'Next',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PriceEstimate()));
                }),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
