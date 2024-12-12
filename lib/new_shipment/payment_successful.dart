import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/new_shipment/e_receipt.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({super.key});

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppImages.mark)),
            SizedBox(height: 30),
            Text(
              'Payment Successful!',
              style: AppTextStyle.body(fontWeight: FontWeight.bold, size: 20),
            ),
            SizedBox(height: 15),
            Container(
              width: 300,
              child: Text(
                textAlign: TextAlign.center,
                'Your payment for shipping has been successful',
                style: AppTextStyle.body(size: 16),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton(
                  borderColor: AppColor.lightgrey,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  textColor: AppColor.black,
                  title: 'Track Delivery',
                  onTap: () {},
                  width: MediaQuery.sizeOf(context).width * 0.45,
                ),
                AppButton(
                  title: 'E-Receipt',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EReceipt()));
                  },
                  width: MediaQuery.sizeOf(context).width * 0.45,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
