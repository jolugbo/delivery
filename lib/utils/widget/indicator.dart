
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gt_delivery/constant/app_color.dart';

class SlideIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;
  const SlideIndicator(
      {super.key, required this.currentIndex, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) => _indicator(currentIndex == index),
      ),
    );
  }

  Widget _indicator(bool isCurrent) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: isCurrent ? 14.w : 6.w,
        height: 6.w,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color:
              isCurrent ? AppColor.primaryColor : AppColor.lightgrey,
          borderRadius: BorderRadius.circular(1000.r),
          // gradient: isCurrent
          //     ? const LinearGradient(
          //         colors: [
          //           Color(0xFF232527),
          //           Color(0xFF111318),
          //         ],
          //       )
          //     : null,
        ),
      );
}



class KYCSlideIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;
  const KYCSlideIndicator(
      {super.key, required this.currentIndex, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container (
     width: double.infinity, 
  alignment: Alignment.centerLeft, 
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max, 
    crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        total,
        (index) => _indicator(index <= currentIndex),
      ),
    ));
  }

  Widget _indicator(bool isCurrent) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 35.w,
        height: 6.w,
        padding: const EdgeInsets.only(left: 0),
        margin: EdgeInsets.only(right: 12.w),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color:
              isCurrent ? AppColor.white : AppColor.indicatorGreyColor,
          borderRadius: BorderRadius.circular(1000.r),
        ),
      );
}
