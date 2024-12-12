import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/new_shipment/courier.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:gt_delivery/widget/app_text_fields.dart';
import 'package:gt_delivery/widget/back_button.dart';
import 'package:gt_delivery/widget/item_button.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({super.key});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  bool? isGeneral = null;
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
                      'Package Details',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.w500, color: AppColor.white),
                    ),
                    Spacer(),
                    Text(
                      '4/6 Step',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  'Package Details',
                  style: AppTextStyle.body(
                      fontWeight: FontWeight.bold, color: AppColor.grey),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Container(
                              height: MediaQuery.sizeOf(context).height * 0.8,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      'Add Item',
                                      style: AppTextStyle.body(
                                          fontWeight: FontWeight.bold,
                                          size: 20),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Add Item to be shipped.',
                                      style: AppTextStyle.body(size: 14),
                                    ),
                                    SizedBox(height: 15),
                                    ItemButton(
                                      onTap: () {
                                        setState(() {
                                          isGeneral = true;
                                        });
                                        print(isGeneral);
                                      },
                                      isActive: isGeneral != null
                                          ? isGeneral!
                                          : false,
                                      imagePath: AppImages.box,
                                      title: 'General Item',
                                      subtitle:
                                          'Everyday items with a variety of purposes',
                                    ),
                                    SizedBox(height: 15),
                                    ItemButton(
                                      onTap: () {
                                        setState(() {
                                          isGeneral = false;
                                        });
                                      },
                                      isActive: isGeneral != null
                                          ? !isGeneral!
                                          : false,
                                      imagePath: AppImages.bowl,
                                      title: 'Food Item',
                                      subtitle: 'Edible  goods for consumption',
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: AppButton(
                                          color: isGeneral != null
                                              ? AppColor.primaryColor
                                              : AppColor.grey,
                                          title: 'Add Item',
                                          onTap: () {
                                            if (isGeneral == true) {
                                              generalItem(context);
                                            } else if (isGeneral == false) {
                                              foodItem(context);
                                            }
                                          }),
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: AddItemWidget(
                    sign: '+',
                    title: 'Add Item',
                  ),
                ),
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
                      MaterialPageRoute(builder: (context) => Courier()));
                }),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<dynamic> generalItem(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Add General Item',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.bold, size: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Add Item to be shipped.',
                      style: AppTextStyle.body(size: 14),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country or Origin',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            hint: Text(
                              'Select where your item is from',
                              style: AppTextStyle.body(size: 14),
                            ),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ))),
                            items: <String>['Nigeria', 'Somalia']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: AppTextStyle.body(size: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Item Name',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: nameController, hint: 'Enter Name'),
                          SizedBox(height: 10),
                          Text(
                            'Item Value',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: valueController, hint: 'Enter Value'),
                          SizedBox(height: 10),
                          Text(
                            'Item Category',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            hint: Text(
                              'Select Category',
                              style: AppTextStyle.body(size: 14),
                            ),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ))),
                            items: <String>['Clothings', 'Electronics']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: AppTextStyle.body(size: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sub Category',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            hint: Text(
                              'Select Category',
                              style: AppTextStyle.body(size: 14),
                            ),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ))),
                            items:
                                <String>['Phones', 'Tools'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: AppTextStyle.body(size: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Color',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: colorController,
                              hint: 'e.g black, green'),
                          SizedBox(height: 10),
                          Text(
                            'What is it made of?',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: textController,
                              hint: 'e.g plastic, wood, metal'),
                          SizedBox(height: 10),
                          Text(
                            'What is it used for?',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: textController,
                              hint: 'e.g driving, sweeping'),
                          SizedBox(height: 10),
                          Text(
                            'Weight',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: textController, hint: 'Enter Weight'),
                          SizedBox(height: 10),
                          Text(
                            'Qty',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: AppColor.lightgrey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '-',
                                  style: AppTextStyle.body(size: 25),
                                ),
                              ),
                              Text(
                                '1',
                                style: AppTextStyle.body(
                                    fontWeight: FontWeight.bold, size: 22),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: AppColor.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '+',
                                  style: AppTextStyle.body(
                                      color: AppColor.white, size: 25),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          AppButton(title: 'Add Item', onTap: () {}),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> foodItem(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Add Food Item',
                      style: AppTextStyle.body(
                          fontWeight: FontWeight.bold, size: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Add Item to be shipped.',
                      style: AppTextStyle.body(size: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Item Name',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: nameController, hint: 'Enter Name'),
                          SizedBox(height: 10),
                          Text(
                            'Item Value',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: valueController, hint: 'Enter Value'),
                          SizedBox(height: 10),
                          Text(
                            'Item Category',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            hint: Text(
                              'Select Category',
                              style: AppTextStyle.body(size: 14),
                            ),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ))),
                            items: <String>['Clothings', 'Electronics']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: AppTextStyle.body(size: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sub Category',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            hint: Text(
                              'Select Category',
                              style: AppTextStyle.body(size: 14),
                            ),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ))),
                            items:
                                <String>['Phones', 'Tools'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: AppTextStyle.body(size: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          SizedBox(height: 10),
                          Text(
                            'What is it used for?',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: textController,
                              hint: 'e.g cooking, food preservation'),
                          SizedBox(height: 10),
                          Text(
                            'What form is the item',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: textController,
                              hint: 'e.g dried, smoked'),
                          SizedBox(height: 10),
                          Text(
                            'How is it packed',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: textController,
                              hint: 'e.g plastic bag, canned'),
                          SizedBox(height: 10),
                          Text(
                            'Weight',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          AppTextFields(
                              controller: textController, hint: 'Enter Weight'),
                          SizedBox(height: 10),
                          Text(
                            'Qty',
                            style: AppTextStyle.body(size: 14),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: AppColor.lightgrey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '-',
                                  style: AppTextStyle.body(size: 25),
                                ),
                              ),
                              Text(
                                '1',
                                style: AppTextStyle.body(
                                    fontWeight: FontWeight.bold, size: 22),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: AppColor.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '+',
                                  style: AppTextStyle.body(
                                      color: AppColor.white, size: 25),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          AppButton(
                              title: 'Add Item',
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.8,
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
                                                SizedBox(height: 10),
                                                Text(
                                                  'Add Food Item',
                                                  style: AppTextStyle.body(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 20),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Add Item to be shipped.',
                                                  style: AppTextStyle.body(
                                                      size: 14),
                                                ),
                                                SizedBox(height: 20),
                                                AddItemWidget(
                                                    sign: '+',
                                                    title: 'Add  Item Image'),
                                                Spacer(),
                                                AppButton(
                                                    title: 'Add Item',
                                                    onTap: () {}),
                                                SizedBox(height: 40),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class AddItemWidget extends StatelessWidget {
  final String sign;
  final String title;
  const AddItemWidget({
    super.key,
    required this.sign,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: DashedRect(
        color: AppColor.lightgrey,
        strokeWidth: 2.0,
        gap: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 20,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.primaryColor),
              child: Text(
                sign,
                style: AppTextStyle.body(
                    color: AppColor.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyle.body(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
