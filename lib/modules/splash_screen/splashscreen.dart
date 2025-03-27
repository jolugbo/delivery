import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/modules/walk_through/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //_initialize();
    super.initState();
   // _navigateToNextPage();
  }

 

  Future<void> _initialize() async {
    //   final prefs = await SharedPreferences.getInstance();
    //   final key = prefs.getString("key");
    //   final id = prefs.getString("username");
    //   if (key != null && key != "") {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => Home(
    //                   token: key,
    //                   userId: id,
    //                 )));
    //   }
    //   else {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WalkthroughScreen()));
    });
    //   //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Image(image: AssetImage(AppImages.whitelogo)),
      ),
    );
  }
}
