import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                const SizedBox(width: 30),
                const GoBackButtton(
                  iconColor: AppColor.black,
                  color: AppColor.white,
                  borderColor: AppColor.lightgrey,
                ),
                const SizedBox(width: 60),
                Text(
                  'Delivery Details',
                  style:
                      AppTextStyle.body(fontWeight: FontWeight.bold, size: 22),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('The package is on it`s way',
                style: AppTextStyle.body(size: 14)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColor.objectColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image(image: AssetImage(AppImages.file)),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'FLX6863121',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.w500, size: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Track ID',
                      style: AppTextStyle.body(size: 13),
                    )
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColor.objectColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image(image: AssetImage(AppImages.clock)),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '4 days',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.w500, size: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Est. Delivery Time',
                      style: AppTextStyle.body(size: 13),
                    )
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColor.objectColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image(image: AssetImage(AppImages.info)),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '2.4 kg',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.w500, size: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Package Weight',
                      style: AppTextStyle.body(size: 13),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryWidget(
                    title: 'Order Placed',
                    date: 'June 25, 2024',
                  ),
                  SizedBox(height: 20),
                  DeliveryWidget(
                    title: 'Package Picked Up',
                    date: 'June 25, 2024 | New York, NY',
                  ),
                  SizedBox(height: 20),
                  DeliveryWidget(
                    title: 'In Transit to Service Center',
                    date: 'June 25, 2024 | Newark, NJ',
                  ),
                  SizedBox(height: 20),
                  DeliveryWidget(
                    title: 'Arrived at Service Center',
                    date: 'June 28, 2024 | Philadelphia, PA',
                  ),
                  SizedBox(height: 20),
                  DeliveryWidget(
                    title: 'Departed Service Center',
                    date: 'June 29, 2024 | Philadelphia, PA',
                  ),
                  SizedBox(height: 20),
                  DeliveryWidget(
                    title: 'Out for Delivery',
                    date: 'June 30, 2024 | Los Angeles, CA',
                  ),
                  SizedBox(height: 20),
                  DeliveryWidget(
                    title: 'On the way to Delivery Destination',
                    date: 'June 30, 2024 | Los Angeles, CA',
                  ),
                  SizedBox(height: 20),
                  DeliveryWidget(
                    title: 'Delivered',
                    date: 'June 30, 2024 | Los Angeles, CA',
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryWidget extends StatelessWidget {
  final String title;
  final String date;
  const DeliveryWidget({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.body(size: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Text(
          date,
          style: AppTextStyle.body(size: 14),
        )
      ],
    );
  }
}
