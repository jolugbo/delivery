import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/core/models/enumerators/button.dart';
import 'package:gt_delivery/core/models/slide_models.dart';
import 'package:gt_delivery/modules/create_account/create_account.dart';
import 'package:gt_delivery/modules/home/home.dart';
import 'package:gt_delivery/modules/login/welcome_back.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/modules/walk_through/widgets/indicator.dart';
import 'package:gt_delivery/modules/walk_through/widgets/slide.dart';
import 'package:gt_delivery/utils/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();


  
}

class _WalkthroughScreenState extends State<WalkthroughScreen>
    with SingleTickerProviderStateMixin {
      
  int index = 0;
  final PageController _controller = PageController();
  
  final List<SlideModel> slides = [
    SlideModel(
      imagePath: AppImages.walkthrough1,
      titleText: 'Send Packages Locally or Across the Globe with Ease',
      subtitleText:
          'Whether local or global, our service makes shipping fast,safe and easy. just few taps, and we\'ll handle the rest!',
    ),
    SlideModel(
      imagePath: AppImages.walkthrough2,
      titleText: 'Stay in the Loop with Real-Time Tracking',
      subtitleText:
          'Get live updates from pickup to delivery. Our advanced tracking keeps you informed every step of the way, giving you peace of mind.',
    ),
    SlideModel(
      imagePath: AppImages.walkthrough3,
      titleText: 'Reliable and Secure Deliveries',
      subtitleText: 'We prioritize security and reliability. From encryption to careful handling, rest assured your package is in trusted hands, every time.',
    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNextPage();
      _animateSlider();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

 Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash screen delay
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Navigate to the Home page if the user is signed in
      final prefs = await SharedPreferences.getInstance();
      final key = prefs.getString("key");
      final id = prefs.getString("username");
      if (key != null && key != "") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      token: key,
                      userId: id,
                    )));
      }
    } 
  }
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          exit(0);
          //showExitAppBottomModal(context);
        },
        child: Scaffold(
          body: Stack(
            children: [
              
              Padding(
                padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 55.h),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _controller,
                        onPageChanged: (val) {
                          index = val;
                          setState(() {});
                        },
                        itemCount: slides.length,
                        itemBuilder: (_, index) => WalkthroughItem(
                          model: slides[index],
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    SlideIndicator(currentIndex: index, total: slides.length),
                    SizedBox(height: 27.h),
                    AppButton(
                      // isValidated: true,
                      buttonText: 'Get Started',
                      onPressed: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateAccount()));
                      },
                    ),
                    SizedBox(height: 12.h),
                    AppButton(
                      textColor: AppColor.lightgrey,
                      buttonType: ButtonType.secondary,
                      buttonText: 'Login',textStyle: AppTextStyle.body(size: 16,color: AppColor.dark),
                      onPressed: () {
                         Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomeBack()));
                      },
                    ),
                    
                  ],
                ),
              ),
              
            ],
          ),
        
        ));
  }



  void _animateSlider() {
    
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if(!_controller.hasClients)return;
      index = _controller.page!.round() + 1;

      if (index == slides.length) {
        index = 0;
      }

      _controller
          .animateToPage(index,
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn)
          .then((_) => _animateSlider());
    });
  }
}
