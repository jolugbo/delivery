import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/back_button.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  const GoBackButtton(
                    iconColor: AppColor.black,
                    color: AppColor.white,
                    borderColor: AppColor.lightgrey,
                  ),
                  SizedBox(width: 80),
                  Text(
                    'Terms & Conditions',
                    style: AppTextStyle.body(
                        fontWeight: FontWeight.bold, size: 20),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Welcome to GT Deliveries ("the App"). These Terms and Conditions ("Terms") govern your use of our delivery services ("Services") in Nigeria and internationally. By accessing or using our Services, you agree to these Terms. If you continue to use our Services, then you agree with these Terms.\n1. International Delivery\n1.1 Service Overview\nWe offer international delivery from Nigeria to over 230 countries with three plans: Premium, Express, and Standard.\n1.2 Plan Details \nPremium Plan: Includes expedited service and may require the payment of applicable duties.\nExpress Plan: Fast-tracked delivery with potential duty payments.\nStandard Plan: Basic delivery service without guaranteed expedited options.\n1.3 Rechecking and Reweighing\nAll items contracted under the Premium, Express, and Standard Plans are subject to rechecking and reweighing. If adjustments are needed, the initial payment may be updated accordingly.\n1.4 Rejection and Returns\nIn the event of rejection of the item after rechecking, a service charge will apply. Customers are responsible for the payment of returning the item.2. Interstate Delivery\n2.1 Service Overview\nWe provide interstate delivery services under the Express and Standard Plans.\n2.2 Plan Details\nExpress Plan: Fast-tracked interstate delivery.\nStandard Plan: Basic interstate delivery service.\n2.3 Rechecking and Reweighing\nAll items contracted under the Express and Standard Plans are also subject to rechecking and reweighing. Adjustments to the initial payment may occur if necessary.\n2.4 Rejection and Returns\nShould an item be rejected after rechecking, a service charge will be incurred, and customers are responsible for the return payment.3. Intra State Delivery\n3.1 Service Overview\nOur intra-state delivery services ensure that all items are insured during transit.\n4. Insurance Policy\n4.1 Coverage\nFor intra-state deliveries, all items are insured against loss or damage during transit, subject to the terms of the insurance policy. Customers should retain proof of value for insured items.\n5. Payment Terms\n5.1 Payment Methods\nPayments for services may be made through the App using available payment methods. All payments should be received in full before services are rendered.\n5.2 Refunds\nRefunds are subject to our refund policy and may not be granted in cases of rejected items, where service charges apply.6. Limitation of Liability\n6.1 Exclusions\nGT Deliveries is not liable for any indirect, incidental, or consequential damages arising from the use of our services or inability to use the App.\n7. Changes to Terms\n7.1 Modifications\nWe reserve the right to update or change these Terms at any time. Any changes will be effective immediately upon posting on the App. Your continued use of the Services after changes are made constitutes your acceptance of the revised Terms.\n8. Governing Law\n8.1 Jurisdiction\nThese Terms shall be governed by and construed in accordance with the laws of the Federal Republic of Nigeria.\n9. Contact Information\n9.1 Customer Support\nFor any questions regarding these Terms or our services, please contact us at info@gtdeliveriesltd.com. You can also reach out to us via our social media handles or send us a message on WhatsApp.',
                style: AppTextStyle.body(color: AppColor.grey, size: 16),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
