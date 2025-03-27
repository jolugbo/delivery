import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double width;
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color = AppColor.primaryColor,
    this.textColor = AppColor.white,
    this.borderColor = AppColor.white,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          height: 60,
          width: width,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: borderColor)),
          child: Text(
            title,
            style: AppTextStyle.body(
                color: textColor, fontWeight: FontWeight.w500),
          )),
    );
  }
}
