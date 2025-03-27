import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';

class GoBackButtton extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final Color borderColor;
  const GoBackButtton({
    super.key,
    this.color = AppColor.bordergrey,
    this.iconColor = AppColor.white,
    this.borderColor = AppColor.bordergrey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: borderColor)),
        child: Icon(Icons.arrow_back, size: 25, color: iconColor),
      ),
    );
  }
}
