import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gt_delivery/modules/account/account.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/modules/home/delivery_details.dart';
import 'package:gt_delivery/modules/new_shipment/new_shipment.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';

class Home extends StatefulWidget {
  final token;
  final userId;
  const Home({super.key, required this.token, required this.userId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final username = ""; //widget.userId;
  late List<Widget> screens; // Declare late variable
  var userProfile = "";
  @override
  void initState() {
    super.initState();

    // Initialize fields here

    screens = [
      HomeScreen(token: widget.token, userId: widget.userId),
      const Center(child: Text('Activity')),
      Account(token: widget.token, userProfile: userProfile),
    ];
  }

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

class HomeScreen extends StatefulWidget {
  final token;
  final userId;
  const HomeScreen({super.key, required this.token, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Function to load data from secure storage
  Future<void> _loadData() async {
    print("value of data is  ${widget.userId}");
    setState(() {
      username = widget.userId ?? "Loading...";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(color: AppColor.primaryColor),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Image(image: AssetImage(AppImages.profilepicture)),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hi, $username',
                              style: AppTextStyle.body(
                                  color: AppColor.white, size: 14),
                            ),
                            const SizedBox(width: 5),
                            Image(image: AssetImage(AppImages.wavee))
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Image(image: AssetImage(AppImages.location)),
                            const SizedBox(width: 5),
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
                const SizedBox(height: 25),
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
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: 'Track your package',
                        hintStyle: AppTextStyle.body(size: 14)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewShipment(token: widget.token,)));
                },
                child: Column(
                  children: [
                    Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFEECED)),
                        child: Image(image: AssetImage(AppImages.motorbike))),
                    const SizedBox(height: 10),
                    Text(
                      'Ship Package',
                      style: AppTextStyle.body(size: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 100),
              Column(
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFEECED)),
                      child: Image(image: AssetImage(AppImages.tag))),
                  const SizedBox(height: 10),
                  Text(
                    'Check Rates',
                    style: AppTextStyle.body(size: 14),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 15),
              Text(
                'Active Deliveries',
                style: AppTextStyle.body(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => const DeliveryDetails()));
          //     },
          //     child: Container(
          //       width: double.infinity,
          //       height: 150,
          //       decoration: BoxDecoration(
          //           border: Border.all(color: AppColor.lightgrey),
          //           borderRadius: BorderRadius.circular(10)),
          //       child: Column(
          //         children: [
          //           const SizedBox(height: 10),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: 60,
          //                 width: 60,
          //                 decoration: BoxDecoration(
          //                     color: const Color(0xffFEECED),
          //                     borderRadius: BorderRadius.circular(8)),
          //                 child: Image(image: AssetImage(AppImages.box)),
          //               ),
          //               const SizedBox(width: 20),
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'FLX7823899',
          //                     style: AppTextStyle.body(
          //                         fontWeight: FontWeight.w600, size: 16),
          //                   ),
          //                   Text(
          //                     'Service Center',
          //                     style: AppTextStyle.body(size: 14),
          //                   ),
          //                   Text(
          //                     'Express Delivery',
          //                     style: AppTextStyle.body(size: 14),
          //                   ),
          //                 ],
          //               ),
          //               const SizedBox(width: 30),
          //               Container(
          //                 alignment: Alignment.center,
          //                 height: 30,
          //                 width: 100,
          //                 decoration: BoxDecoration(
          //                     color: const Color(0xffFFF6E0),
          //                     borderRadius: BorderRadius.circular(15)),
          //                 child: Text(
          //                   'In Progress',
          //                   style: AppTextStyle.body(
          //                       size: 14,
          //                       color: const Color(0xffFFBE4C),
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const SizedBox(height: 18),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 alignment: Alignment.center,
          //                 height: 35,
          //                 width: 320,
          //                 decoration: BoxDecoration(
          //                     color: AppColor.primaryColor,
          //                     borderRadius: BorderRadius.circular(20)),
          //                 child: Text(
          //                   'Track',
          //                   style: AppTextStyle.body(
          //                       size: 15,
          //                       color: AppColor.white,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Container(
          //     width: double.infinity,
          //     height: 150,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: AppColor.lightgrey),
          //         borderRadius: BorderRadius.circular(10)),
          //     child: Column(
          //       children: [
          //         const SizedBox(height: 10),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //               height: 60,
          //               width: 60,
          //               decoration: BoxDecoration(
          //                   color: const Color(0xffFEECED),
          //                   borderRadius: BorderRadius.circular(8)),
          //               child: Image(image: AssetImage(AppImages.box)),
          //             ),
          //             const SizedBox(width: 20),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   'FLX7823899',
          //                   style: AppTextStyle.body(
          //                       fontWeight: FontWeight.w600, size: 16),
          //                 ),
          //                 Text(
          //                   'Service Center',
          //                   style: AppTextStyle.body(size: 14),
          //                 ),
          //                 Text(
          //                   'Express Delivery',
          //                   style: AppTextStyle.body(size: 14),
          //                 ),
          //               ],
          //             ),
          //             const SizedBox(width: 30),
          //             Container(
          //               alignment: Alignment.center,
          //               height: 30,
          //               width: 100,
          //               decoration: BoxDecoration(
          //                   color: const Color(0xffFFF6E0),
          //                   borderRadius: BorderRadius.circular(15)),
          //               child: Text(
          //                 'In Progress',
          //                 style: AppTextStyle.body(
          //                     size: 14,
          //                     color: const Color(0xffFFBE4C),
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 18),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //               alignment: Alignment.center,
          //               height: 35,
          //               width: 160,
          //               decoration: BoxDecoration(
          //                   border: Border.all(color: AppColor.grey),
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Text(
          //                 'Make Payment',
          //                 style: AppTextStyle.body(
          //                     size: 14,
          //                     color: AppColor.black,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //             const SizedBox(width: 10),
          //             Container(
          //               alignment: Alignment.center,
          //               height: 35,
          //               width: 160,
          //               decoration: BoxDecoration(
          //                   color: AppColor.primaryColor,
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Text(
          //                 'Track',
          //                 style: AppTextStyle.body(
          //                     size: 15,
          //                     color: AppColor.white,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Container(
          //     width: double.infinity,
          //     height: 150,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: AppColor.lightgrey),
          //         borderRadius: BorderRadius.circular(10)),
          //     child: Column(
          //       children: [
          //         const SizedBox(height: 10),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //               height: 60,
          //               width: 60,
          //               decoration: BoxDecoration(
          //                   color: const Color(0xffFEECED),
          //                   borderRadius: BorderRadius.circular(8)),
          //               child: Image(image: AssetImage(AppImages.box)),
          //             ),
          //             const SizedBox(width: 20),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   'FLX7823899',
          //                   style: AppTextStyle.body(
          //                       fontWeight: FontWeight.w600, size: 16),
          //                 ),
          //                 Text(
          //                   'Service Center',
          //                   style: AppTextStyle.body(size: 14),
          //                 ),
          //                 Text(
          //                   'Express Delivery',
          //                   style: AppTextStyle.body(size: 14),
          //                 ),
          //               ],
          //             ),
          //             const SizedBox(width: 30),
          //             Container(
          //               alignment: Alignment.center,
          //               height: 30,
          //               width: 100,
          //               decoration: BoxDecoration(
          //                   color: const Color(0xffFFF6E0),
          //                   borderRadius: BorderRadius.circular(15)),
          //               child: Text(
          //                 'In Progress',
          //                 style: AppTextStyle.body(
          //                     size: 14,
          //                     color: const Color(0xffFFBE4C),
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 18),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //               alignment: Alignment.center,
          //               height: 35,
          //               width: 320,
          //               decoration: BoxDecoration(
          //                   color: AppColor.primaryColor,
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Text(
          //                 'Track',
          //                 style: AppTextStyle.body(
          //                     size: 15,
          //                     color: AppColor.white,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 50)
        ],
      ),
    );
  }
}
