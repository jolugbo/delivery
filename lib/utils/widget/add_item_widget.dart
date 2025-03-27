
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';

class AddItemWidget extends StatelessWidget {
  final String title;
  const AddItemWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: DashedRect(
        color: AppColor.lightgrey,
        strokeWidth: 2.0,
        gap: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_rounded, size: 25, color: AppColor.primaryColor),
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
