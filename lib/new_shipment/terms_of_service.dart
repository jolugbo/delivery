import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/new_shipment/pickup_information.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/back_button.dart';

class TermsOfService extends StatefulWidget {
  final String shippingType;
  const TermsOfService({super.key, required this.shippingType});

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
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
              GoBackButtton(
                iconColor: AppColor.black,
                color: AppColor.white,
                borderColor: AppColor.grey,
              ),
              SizedBox(height: 20),
              Text(
                'Terms Of Service',
                style: AppTextStyle.body(size: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'By using our international delivery services, you agree to the following terms:',
                style: AppTextStyle.body(size: 14, color: AppColor.grey),
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '1. ',
                title: 'Service Scope:',
                desc:
                    'We offer international shipping to and from select countries. Service availability may vary based on destination, regulations, and shipping partners.',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '2. ',
                title: 'Customs Attestation:',
                desc:
                    ' You, as the shipper, are responsible for providing accurate and complete customs documentation, including declaration of contents, value, and country of origin. By using this service, you attest that all items comply with the customs laws and regulations of the destination country. You confirm that the shipment does not contain prohibited or restricted goods as defined by customs authorities in both the origin and destination countries. Any penalties, delays, or confiscation due to false or incomplete customs information will be the sole responsibility of the shipper.',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '3. ',
                title: 'Duties and Taxes:',
                desc:
                    '  Duties, taxes, and other import fees may be applicable in the destination country, and the receiver is responsible for paying any fees unless otherwise arranged. We are not responsible for delays caused by customs clearance in the destination country',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '4. ',
                title: 'Prohibited and Restricted Items:',
                desc:
                    'Certain items are prohibited or restricted for international shipment, such as hazardous materials, perishable goods, weapons, and counterfeit items. It is your responsibility to ensure compliance with local and international laws. Failure to comply may result in the return, delay, or destruction of the shipment.',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '5. ',
                title: 'Payment Adjustments:',
                desc:
                    'Initial payment is based on estimated weight and volume at the time of booking. However, final charges may be updated after the items are checked, properly packed, and reweighed. Any differences in weight, volume, or packaging will result in an adjustment to the final cost, which must be paid before shipment.',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '6. ',
                title: 'Rejected Items:',
                desc:
                    'Items that are rejected for shipment due to non-compliance, incorrect documentation, or other reasons will incur a service charge. The customer is responsible for the cost of returning rejected items to the original sender, and these must be paid before return arrangements are made.',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '7. ',
                title: 'Liability:',
                desc:
                    'Our liability for loss or damage of international shipments is limited by international shipping regulations. Additional insurance may be available for purchase.',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '8. ',
                title: 'Delivery Timeframe:',
                desc:
                    'Estimated delivery times are provided based on average transit times to the destination. However, unforeseen delays such as customs inspections, natural disasters, or political disruptions may extend delivery times.',
              ),
              const SizedBox(height: 3),
              const TermsOfServiceWidget(
                number: '9. ',
                title: 'Claims:',
                desc:
                    'Claims for lost, damaged, or delayed shipments must be made within 5 working days of the scheduled delivery date and will be processed in accordance with international shipping guidelines.',
              ),
              const SizedBox(height: 3),
              Text(
                'By using our international delivery service, you acknowledge and agree to these terms, including full responsibility for customs compliance, payment adjustments, and the return of rejected items.',
                style: AppTextStyle.body(size: 14, color: AppColor.grey),
              ),
              const SizedBox(height: 70),
              AppButton(
                  title: 'Continue',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PickupInformation(
                                  shippingType: widget.shippingType,
                                )));
                  }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsOfServiceWidget extends StatelessWidget {
  final String number;
  final String title;
  final String desc;
  const TermsOfServiceWidget({
    super.key,
    required this.number,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number, style: AppTextStyle.body(size: 14, color: AppColor.grey)),
        Container(
          width: 350,
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: title,
              style: AppTextStyle.body(
                  size: 14, fontWeight: FontWeight.bold, color: AppColor.grey),
            ),
            TextSpan(
                text: desc,
                style: AppTextStyle.body(size: 14, color: AppColor.grey)),
          ])),
        ),
      ],
    );
  }
}
