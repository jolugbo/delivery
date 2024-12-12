import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gt_delivery/account/account.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/home/delivery_details.dart';
import 'package:gt_delivery/new_shipment/new_shipment.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Activity')),
    const Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset((AppImages.home)), label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset((AppImages.vector1)), label: 'Activity'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset((AppImages.vector2)), label: 'Account')
          ]),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(color: AppColor.primaryColor),
            child: Column(
              children: [
                SizedBox(height: 60),
                Row(
                  children: [
                    SizedBox(width: 40),
                    Image(image: AssetImage(AppImages.profilepicture)),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hi, Aaron',
                              style: AppTextStyle.body(
                                  color: AppColor.white, size: 14),
                            ),
                            SizedBox(width: 5),
                            Image(image: AssetImage(AppImages.wavee))
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Image(image: AssetImage(AppImages.location)),
                            SizedBox(width: 5),
                            Text(
                              'California, United States',
                              style: AppTextStyle.body(
                                  color: AppColor.white, size: 14),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    style: AppTextStyle.body(size: 14),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: 'Track your package',
                        hintStyle: AppTextStyle.body(size: 14)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewShipment()));
                },
                child: Column(
                  children: [
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFEECED)),
                        child: Image(image: AssetImage(AppImages.motorbike))),
                    SizedBox(height: 10),
                    Text(
                      'Ship Package',
                      style: AppTextStyle.body(size: 14),
                    )
                  ],
                ),
              ),
              SizedBox(width: 100),
              Column(
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFEECED)),
                      child: Image(image: AssetImage(AppImages.tag))),
                  SizedBox(height: 10),
                  Text(
                    'Check Rates',
                    style: AppTextStyle.body(size: 14),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 15),
          Divider(),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'Active Deliveries',
                style: AppTextStyle.body(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeliveryDetails()));
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.lightgrey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Color(0xffFEECED),
                              borderRadius: BorderRadius.circular(8)),
                          child: Image(image: AssetImage(AppImages.box)),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FLX7823899',
                              style: AppTextStyle.body(
                                  fontWeight: FontWeight.w600, size: 16),
                            ),
                            Text(
                              'Service Center',
                              style: AppTextStyle.body(size: 14),
                            ),
                            Text(
                              'Express Delivery',
                              style: AppTextStyle.body(size: 14),
                            ),
                          ],
                        ),
                        SizedBox(width: 30),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Color(0xffFFF6E0),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            'In Progress',
                            style: AppTextStyle.body(
                                size: 14,
                                color: Color(0xffFFBE4C),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 320,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'Track',
                            style: AppTextStyle.body(
                                size: 15,
                                color: AppColor.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.lightgrey),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Color(0xffFEECED),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image(image: AssetImage(AppImages.box)),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FLX7823899',
                            style: AppTextStyle.body(
                                fontWeight: FontWeight.w600, size: 16),
                          ),
                          Text(
                            'Service Center',
                            style: AppTextStyle.body(size: 14),
                          ),
                          Text(
                            'Express Delivery',
                            style: AppTextStyle.body(size: 14),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffFFF6E0),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'In Progress',
                          style: AppTextStyle.body(
                              size: 14,
                              color: Color(0xffFFBE4C),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 160,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Make Payment',
                          style: AppTextStyle.body(
                              size: 14,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 160,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Track',
                          style: AppTextStyle.body(
                              size: 15,
                              color: AppColor.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.lightgrey),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Color(0xffFEECED),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image(image: AssetImage(AppImages.box)),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FLX7823899',
                            style: AppTextStyle.body(
                                fontWeight: FontWeight.w600, size: 16),
                          ),
                          Text(
                            'Service Center',
                            style: AppTextStyle.body(size: 14),
                          ),
                          Text(
                            'Express Delivery',
                            style: AppTextStyle.body(size: 14),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffFFF6E0),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'In Progress',
                          style: AppTextStyle.body(
                              size: 14,
                              color: Color(0xffFFBE4C),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 320,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Track',
                          style: AppTextStyle.body(
                              size: 15,
                              color: AppColor.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}
