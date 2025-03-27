import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/modules/new_shipment/e_receipt.dart';
import 'package:gt_delivery/provider/delivery_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:provider/provider.dart';

class PaymentSuccessful extends StatefulWidget {
  final token;
  final paymentResponse;
  final orderRequest;
  const PaymentSuccessful(
      {super.key, required this.token, required this.paymentResponse, required this.orderRequest});

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  bool isLoading = false;

  void _loadData() async {
    setState(() {
      isLoading = true;
    });
    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    final uri = Uri.parse(widget.paymentResponse);
    try {
      var paymentRequest = {
        "transactionId":uri.queryParameters['transaction_id'] ?? '', 
        "transactionRef": uri.queryParameters['tx_ref'] ?? '',
        "status": uri.queryParameters['status'] ?? ''
      };
      final deliveryProvider =
          Provider.of<DeliveryProvider>(context, listen: false);
      final response = await deliveryProvider.confirmpayment(
          token: widget.token, paymentRequest: paymentRequest);
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      // Handle errors here
      print('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
     _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppImages.mark)),
            const SizedBox(height: 30),
            Text(
              'Payment Successful!',
              style: AppTextStyle.body(fontWeight: FontWeight.bold, size: 20),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: Text(
                textAlign: TextAlign.center,
                'Your payment for shipping has been successful',
                style: AppTextStyle.body(size: 16),
              ),
            ),
            const SizedBox(height: 50),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EReceipt(orderRequest: widget.orderRequest,token: widget.token,)));
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
