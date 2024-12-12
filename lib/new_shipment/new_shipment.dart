import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/new_shipment/terms_of_service.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/back_button.dart';
import 'package:gt_delivery/widget/item_button.dart';

class NewShipment extends StatefulWidget {
  const NewShipment({super.key});

  @override
  State<NewShipment> createState() => _NewShipmentState();
}

class _NewShipmentState extends State<NewShipment> {
  String shippingType = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(width: 30),
                    GoBackButtton(),
                    SizedBox(width: 60),
                    Text(
                      'New Shipment',
                      style: AppTextStyle.body(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          size: 22),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      'Shipment type',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.bold, color: AppColor.white),
                    ),
                    Spacer(),
                    Text(
                      '1/6 Step',
                      style: AppTextStyle.body(size: 16, color: AppColor.white),
                    ),
                    SizedBox(width: 20)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  ItemButton(
                      isActive: shippingType == 'International Shipping',
                      imagePath: AppImages.world,
                      title: 'International Shipping',
                      subtitle: 'Send packages internationally',
                      onTap: () {
                        setState(() {
                          shippingType = 'International Shipping';
                        });
                      }),
                  SizedBox(height: 20),
                  ItemButton(
                      isActive: shippingType == 'Inter-State Shipping',
                      imagePath: AppImages.world,
                      title: 'Inter-State Shipping',
                      subtitle: 'Send packages nationwide.',
                      onTap: () {
                        setState(() {
                          shippingType = 'Inter-State Shipping';
                        });
                      }),
                  const SizedBox(height: 20),
                  ItemButton(
                      isActive: shippingType == 'Intra-State Shipping',
                      imagePath: AppImages.world,
                      title: 'Intra-State Shipping',
                      subtitle: 'Send packages within your state.',
                      onTap: () {
                        setState(() {
                          shippingType = 'Intra-State Shipping';
                        });
                      }),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppButton(
                color:
                    shippingType == '' ? AppColor.grey : AppColor.primaryColor,
                title: 'Next',
                onTap: () {
                  if (shippingType == '') return;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsOfService(
                                shippingType: shippingType,
                              )));
                }),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}
