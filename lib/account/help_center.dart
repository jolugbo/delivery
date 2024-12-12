import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/back_button.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
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
                    'Help Center',
                    style: AppTextStyle.body(
                        fontWeight: FontWeight.bold, size: 20),
                  ),
                ],
              ),
              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    filled: true,
                    fillColor: AppColor.bordergrey,
                    hintStyle: AppTextStyle.body(size: 15)),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text('Lorem ipsum dolar sit amet',
                      style: AppTextStyle.body(
                          size: 16, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 28, color: AppColor.grey),
                ],
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('Lorem ipsum dolar sit amet',
                      style: AppTextStyle.body(
                          size: 16, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 28, color: AppColor.grey),
                ],
              ),
              Text(
                'Turpis lectus egestas dui proin natoque nulla egestas fames molestie. Euismod orci nisl enim pharetra lectus morbi massa nibh non.',
                style: AppTextStyle.body(size: 14, color: AppColor.grey),
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('Lorem ipsum dolar sit amet',
                      style: AppTextStyle.body(
                          size: 16, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 28, color: AppColor.grey),
                ],
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('Lorem ipsum dolar sit amet',
                      style: AppTextStyle.body(
                          size: 16, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 28, color: AppColor.grey),
                ],
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('Lorem ipsum dolar sit amet',
                      style: AppTextStyle.body(
                          size: 16, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 28, color: AppColor.grey),
                ],
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
