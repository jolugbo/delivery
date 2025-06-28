import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/modules/new_shipment/payment_successful.dart';
import 'package:gt_delivery/provider/delivery_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:gt_delivery/utils/widget/custom_browser.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  final token;
  final paymentDetails;
  final orderRequest;
  const Payment(
      {required this.token,
      super.key,
      required this.paymentDetails,
      required this.orderRequest});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.orderRequest["paymentDetails"] = widget.paymentDetails;
    });
  }

  Future<void> launchInApp() async {
    Navigator.of(context).pop();
    setState(() {
      isLoading = true;
    });
    var paymentRequest = {
      "amount":
          "3000", //widget.paymentDetails["totalAmount"], // amount to be paid
      "redirectUrl": "gtdelivery://payment-success", // optional
      "email": widget
          .paymentDetails["email"], // email of the customer making payment
      "crossReference": widget.paymentDetails["orderNo"], // shipment order no
      "card-id": "string" // optional
    };
    print(paymentRequest);
//
    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    final response = await deliveryProvider.createpayment(
        token: widget.token, paymentRequest: paymentRequest);
    setState(() {
      isLoading = false;
    });
    if (response["success"]) {
      print(response);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomBrowser(
            url: response["data"],
          ),
        ),
      ).then((returnedUrl) {
        if (returnedUrl != null) {
          print('User reached target URL: $returnedUrl');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentSuccessful(
                      token: widget.token,
                      paymentResponse: returnedUrl,
                      orderRequest: widget.orderRequest)));
        }
      });
    }
  }



  Widget rowItem(String title, String value,
      {Color? color, FontWeight? fontWeight}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.body(size: 14),
        ),
        Text(
          value,
          style: AppTextStyle.body(
            size: 14,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? AppColor.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment',
                          style: AppTextStyle.body(
                              size: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Select the payment method you want to use to continue',
                          style: AppTextStyle.body(size: 14),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.lightgrey)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                rowItem('Package',
                                    '${widget.paymentDetails["shipmentFee"]["freightFee"]}'),
                                const SizedBox(height: 15),
                                rowItem('Courier',
                                    '${widget.paymentDetails["shipmentFee"]["pickupFee"]}'),
                                const SizedBox(height: 15),
                                rowItem('Insurance',
                                    '${widget.paymentDetails["shipmentFee"]["insuranceFee"]}'),
                                const SizedBox(height: 25),
                                rowItem(
                                  'Total',
                                  '${widget.paymentDetails["totalAmount"]}',
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        PaymentWidget(
                            imagePath: AppImages.paystack, title: 'Paystack'),
                        const SizedBox(height: 15),
                        PaymentWidget(
                            imagePath: AppImages.flutterwave,
                            title: 'Flutterwave'),
                        const SizedBox(height: 15),
                        PaymentWidget(
                            imagePath: AppImages.paypal, title: 'PayPal'),
                        const SizedBox(height: 30),
                        AppButton(
                            title: 'Make Payment',
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.6,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15))),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 40),
                                              Image(
                                                  image: AssetImage(
                                                      AppImages.boxx)),
                                              const SizedBox(height: 40),
                                              Text(
                                                'Price Subject to change',
                                                style: AppTextStyle.body(
                                                    fontWeight: FontWeight.bold,
                                                    size: 25),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                textAlign: TextAlign.center,
                                                'Final price will be determined upon inspection of the package at the center, after which the price will be updated.',
                                                style:
                                                    AppTextStyle.body(size: 15),
                                              ),
                                              const Spacer(),
                                              AppButton(
                                                  title: 'Continue to payment',
                                                  onTap: () {
                                                    launchInApp();
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             const PaymentSuccessful()));
                                                  }),
                                              const SizedBox(height: 40)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
        ],
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
          const SizedBox(width: 20),
          Image(image: AssetImage(imagePath)),
          const SizedBox(width: 10),
          Text(
            title,
            style: AppTextStyle.body(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
