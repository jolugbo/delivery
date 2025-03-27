import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:gt_delivery/utils/widget/item_button.dart';

class PriceEstimate extends StatefulWidget {
  const PriceEstimate({super.key});

  @override
  State<PriceEstimate> createState() => _PriceEstimateState();
}

class _PriceEstimateState extends State<PriceEstimate> {
  bool checkedValue = false;
  bool destinationValue = false;
  String selectedPackage = '';

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
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 5),
                      const GoBackButtton(),
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
                      const SizedBox(width: 5)
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        'Price Estimate',
                        style: AppTextStyle.body(
                            fontWeight: FontWeight.w500, color: AppColor.white),
                      ),
                      const Spacer(),
                      Text(
                        '6/6 Step',
                        style:
                            AppTextStyle.body(size: 16, color: AppColor.white),
                      ),
                      const SizedBox(width: 20)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Beverly Hills, California',
                              style: AppTextStyle.body(
                                  fontWeight: FontWeight.w500, size: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Pickup Location',
                              style: AppTextStyle.body(size: 12),
                            ),
                          ],
                        ),
                      ),
                      Image(image: AssetImage(AppImages.arrow)),
                      SizedBox(
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
                            const SizedBox(height: 10),
                            Text(
                              'Package Destination',
                              style: AppTextStyle.body(size: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    '5-10kg',
                    style: AppTextStyle.body(
                        size: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Package Size',
                    style: AppTextStyle.body(size: 12),
                  ),
                  const SizedBox(height: 10),
                  ItemButton(
                      isActive: selectedPackage == 'Standard',
                      imagePath: AppImages.box,
                      title: 'Standard',
                      subtitle: '6-15 days',
                      trailing: '12,000',
                      onTap: () {
                        setState(() {
                          selectedPackage = 'Standard';
                        });
                      }),
                  const SizedBox(height: 10),
                  ItemButton(
                      isActive: selectedPackage == 'Premium',
                      imagePath: AppImages.box,
                      title: 'Premium',
                      subtitle: '3-5 days',
                      trailing: '15,000',
                      onTap: () {
                        setState(() {
                          selectedPackage = 'Premium';
                        });
                      }),
                  const SizedBox(height: 10),
                  ItemButton(
                      isActive: selectedPackage == 'Express',
                      imagePath: AppImages.box,
                      title: 'Express',
                      subtitle: '1-2 days',
                      trailing: '40,000',
                      onTap: () {
                        setState(() {
                          selectedPackage = 'Express';
                        });
                      }),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          activeColor: AppColor.primaryColor,
                          title: Text(
                            "Insurance",
                            style: AppTextStyle.body(
                                fontWeight: FontWeight.w500, size: 16),
                          ),
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Text(
                        '3,000',
                        style: AppTextStyle.body(
                            size: 14,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          activeColor: AppColor.primaryColor,
                          title: Text(
                            "Destination Duty Fee",
                            style: AppTextStyle.body(
                                fontWeight: FontWeight.w500, size: 16),
                          ),
                          value: destinationValue,
                          onChanged: (newValue) {
                            setState(() {
                              destinationValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Text(
                        '3,000',
                        style: AppTextStyle.body(
                            size: 14,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: Text(
                  textAlign: TextAlign.center,
                  'Final price will be determined upon inspection of the package',
                  style: AppTextStyle.body(size: 14),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton(
                  borderColor: AppColor.lightgrey,
                  color: AppColor.white,
                  textColor: AppColor.black,
                  title: 'Schedule',
                  onTap: () {},
                  width: MediaQuery.sizeOf(context).width * 0.35,
                ),
                AppButton(
                  title: 'Next',
                  onTap: () {
                    // Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const Payment(
                    //                   token: "widget.token",
                    //                 )));
                  },
                  width: MediaQuery.sizeOf(context).width * 0.35,
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
