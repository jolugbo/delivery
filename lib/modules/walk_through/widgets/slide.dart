import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/core/models/slide_models.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';

class WalkthroughItem extends StatelessWidget {
  final SlideModel model;
  const WalkthroughItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return 
     SizedBox(
  width: double.infinity, // Ensures the column takes the full width
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center, // Center aligns the content horizontally
    children: [
      Expanded(
        child: Image.asset(
          model.imagePath,
          height: 200.h,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child:Text(
        model.titleText,
        textAlign: TextAlign.center,
        style: AppTextStyle.body(fontWeight: FontWeight.bold, size: 27,color: AppColor.dark),
      ),      
      ),
      
      SizedBox(height: 8.h),
      Padding(
        padding: EdgeInsets.fromLTRB(12.h, 5, 12.h, 10),
        child:Text(
        model.subtitleText,
        textAlign: TextAlign.center,
        style: AppTextStyle.body(size: 16,color: AppColor.lightdark),
      ),    
      ),
      
    ],
  ),
);

  }
}
