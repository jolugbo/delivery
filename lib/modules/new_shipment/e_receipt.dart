import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/provider/delivery_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

class EReceipt extends StatefulWidget {
  final orderRequest;
  final token;
  const EReceipt({super.key, required this.orderRequest, required this.token});

  @override
  State<EReceipt> createState() => _EReceiptState();
}

class _EReceiptState extends State<EReceipt> {
  bool isLoading = true;
  dynamic receipt = {};
  late Future<Map<String, dynamic>> _receiptFuture;

  void _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final deliveryProvider =
          Provider.of<DeliveryProvider>(context, listen: false);
      _receiptFuture = deliveryProvider.fetchReceipt(
          token: widget.token,
          orderNo: widget.orderRequest["paymentDetails"]["orderNo"]);
      // setState(() {
      //   isLoading = false;
      //   receipt = receiptResponse["data"];
      // });
      print("receipt ${widget.orderRequest}");
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('d MMM yyyy').format(dateTime);
  }

  pw.Widget _buildRow(String title, String value,
      {PdfColor color = PdfColors.black}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 14, color: PdfColors.grey)),
        pw.Text(value,
            style: pw.TextStyle(
                fontSize: 14, fontWeight: pw.FontWeight.bold, color: color)),
      ],
    );
  }

//   Future<void> _generatePDF() async {
//     final ttfRegular = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
// final ttfBold = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));
// // pw.Text("Your Text", style: pw.TextStyle(font: ttfRegular)),
// // pw.Text("Bold Text", style: pw.TextStyle(font: ttfBold, fontWeight: pw.FontWeight.bold)),
//     final pdf = pw.Document();
//     final ByteData data = await rootBundle.load("assets/images/arrow.png");
//     final ByteData data2 = await rootBundle.load("assets/images/barcode.png");
//     final Uint8List imageBytes = data.buffer.asUint8List();
//     final Uint8List imageBytes2 = data2.buffer.asUint8List();
//     // Convert to pw.Image format
//     final image = pw.MemoryImage(imageBytes);
//     final barcode = pw.MemoryImage(imageBytes2);
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text("E-Receipt",
//                 style:
//                     pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold,font: ttfBold,)),
//             pw.SizedBox(height: 20),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(
//                   width: 150,
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         '${receipt["destinationLocation"]["addressLine"]}',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold,font: ttfBold, fontSize: 14),
//                       ),
//                       pw.SizedBox(height: 10),
//                       pw.Text(
//                         'Pickup Location',
//                         style: pw.TextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.Image(image, width: 50, height: 50),
//                 pw.SizedBox(
//                   width: 150,
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                     children: [
//                       pw.Text(
//                         textAlign: pw.TextAlign.end,
//                         '${receipt["pickupLocation"]["addressLine"]}',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold, fontSize: 14),
//                       ),
//                       pw.SizedBox(height: 10),
//                       pw.Text(
//                         'Package Destination',
//                         style: pw.TextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 15),
//             pw.Container(
//               constraints: pw.BoxConstraints.expand(),
//               padding: pw.EdgeInsets.symmetric(vertical: 15),
//               decoration: pw.BoxDecoration(
//                 border:
//                     pw.Border.all(color: PdfColors.grey), // Fixed border color
//                 borderRadius: pw.BorderRadius.circular(10),
//               ),
//               child: pw.Padding(
//                 padding: pw.EdgeInsets.symmetric(horizontal: 20),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     _buildRow('Receiver', receipt["receiver"]["firstName"]),
//                     pw.SizedBox(height: 15),
//                     _buildRow(
//                         'Phone Number', receipt["receiver"]["phoneNumber"]),
//                     pw.SizedBox(height: 15),
//                     _buildRow(
//                         'Email',
//                         widget.orderRequest["receiver"]
//                             ["email"]), // Fixed access issue
//                     pw.SizedBox(height: 15),
//                     _buildRow(
//                       'Address',
//                       (receipt["destinationLocation"]["addressLine"].length >
//                               30)
//                           ? "${receipt["destinationLocation"]["addressLine"].substring(0, 30)}..."
//                           : receipt["destinationLocation"]["addressLine"],
//                     ),
//                     pw.SizedBox(height: 15),
//                     _buildRow(
//                       'Estimated Delivery Date',
//                       formatDate(receipt["estimatedDeliveryDate"]),
//                       color: PdfColors.blue, // Added color
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             pw.SizedBox(height: 15),
//             pw.Container(
//               constraints: pw.BoxConstraints.expand(),
//               padding: pw.EdgeInsets.symmetric(vertical: 15),
//               decoration: pw.BoxDecoration(
//                 border:
//                     pw.Border.all(color: PdfColors.grey), // Fixed border color
//                 borderRadius: pw.BorderRadius.circular(10),
//               ),
//               child: pw.Padding(
//                 padding: pw.EdgeInsets.symmetric(horizontal: 20),
//                 child: pw.Column(
//                   children: [
//                     _buildRow('Payment Method', receipt["paymentMethod"]),
//                     pw.SizedBox(height: 15),
//                     _buildRow('Trackign ID', receipt["trackingId"]),
//                     pw.SizedBox(height: 15),
//                     _buildRow('Shipping Method', receipt["shipmentType"]),
//                     pw.SizedBox(height: 15),
//                     _buildRow('Status', receipt["state"]),
//                   ],
//                 ),
//               ),
//             ),
//             pw.SizedBox(height: 15),
//             pw.Container(
//               constraints: pw.BoxConstraints.expand(),
//               padding: pw.EdgeInsets.symmetric(vertical: 15),
//               decoration: pw.BoxDecoration(
//                 border:
//                     pw.Border.all(color: PdfColors.grey), // Fixed border color
//                 borderRadius: pw.BorderRadius.circular(10),
//               ),
//               child: pw.Padding(
//                 padding: pw.EdgeInsets.symmetric(horizontal: 20),
//                 child: pw.Column(
//                   children: [
//                     _buildRow(
//                         'Package', "${receipt["shipmentFee"]["freightFee"]}"),
//                     pw.SizedBox(height: 15),
//                     _buildRow('Courier', "${receipt["shipmentFee"]["pickupFee"]}"),
//                     pw.SizedBox(height: 15),
//                     _buildRow(
//                         'Insurance', "${receipt["shipmentFee"]["insuranceFee"]}"),
//                     pw.SizedBox(height: 15),
//                     _buildRow('Destination Duty Fee', "0.00"),
//                     pw.SizedBox(height: 25),
//                     _buildRow('Total', "${receipt["totalAmount"]}"),
//                   ],
//                 ),
//               ),
//             ),
//             pw.SizedBox(height: 15),
//             pw.Image(barcode),
//             pw.Text(
//               '${receipt["trackingId"]}',
//               style: pw.TextStyle(fontSize: 14),
//             ),
//             pw.SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );

//     // Get the storage directory
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = "${directory.path}/E-Receipt.pdf";
//     final file = File(filePath);

//     await file.writeAsBytes(await pdf.save());

//     // Open the PDF
//     await Printing.sharePdf(bytes: await pdf.save(), filename: "E-Receipt.pdf");
//   }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    return Scaffold(
        body: Stack(children: <Widget>[
      SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
              future: _receiptFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.black.withOpacity(0.5),
                    height: size.height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500),
                  ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                    "Error Fetching Receipt",
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500),
                  ));
                }
                final receiptResponse = snapshot.data!;
                receipt = receiptResponse["data"];
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const GoBackButtton(
                              iconColor: AppColor.black,
                              color: AppColor.white,
                              borderColor: AppColor.lightgrey,
                            ),
                            Text(
                              'E-Receipt',
                              style: AppTextStyle.body(
                                  fontWeight: FontWeight.bold),
                            ),
                            Image(image: AssetImage(AppImages.printer))
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${receipt["pickupLocation"]["addressLine"]}',
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
                                    '${receipt["destinationLocation"]["addressLine"]}',
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
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.lightdark)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Receiver',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["receiver"]["firstName"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.lightdark),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Phone Number',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["receiver"]["phoneNumber"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.lightdark),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Email',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${widget.orderRequest["receiver"]["email"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.lightdark),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Address',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        receipt["destinationLocation"]
                                                        ["addressLine"]
                                                    .length >
                                                30
                                            ? "${receipt["destinationLocation"]["addressLine"].substring(0, 30)}..."
                                            : "${receipt["destinationLocation"]["addressLine"]}",
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.lightdark),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Estimated Delivery Date',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        formatDate(
                                            '${receipt["estimatedDeliveryDate"]}'),
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
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.lightdark)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Payment Methods',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["paymentMethod"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.lightdark),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Trackign ID',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["trackingId"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shipping Method',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["shipmentType"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Status',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffFFF6E0),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          '${receipt["state"]}',
                                          style: AppTextStyle.body(
                                              size: 14,
                                              color: const Color(0xffFFBE4C),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.lightdark)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Package',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["shipmentFee"]["freightFee"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Courier',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["shipmentFee"]["pickupFee"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Insurance',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["shipmentFee"]["insuranceFee"]}',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Destination Duty Fee',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '0.00',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]),
                                const SizedBox(height: 25),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: AppTextStyle.body(
                                            size: 14,
                                            color: AppColor.lightdark),
                                      ),
                                      Text(
                                        '${receipt["totalAmount"]}',
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
                        const SizedBox(height: 15),
                        Image(image: AssetImage(AppImages.barcode)),
                        Text(
                          '${receipt["trackingId"]}',
                          style: AppTextStyle.body(size: 14),
                        ),
                        const SizedBox(height: 50),
                        AppButton(title: 'Download PDF', onTap: () {}),
                        const SizedBox(height: 20)
                      ],
                    ));
              },
            ),
      ),
      // if (isLoading)
      //   Container(
      //     color: Colors.black.withOpacity(0.5),
      //     child: const Center(
      //       child: CircularProgressIndicator(
      //         color: AppColor.primaryColor,
      //       ),
      //     ),
      //   ),
    ]));
  }
}
