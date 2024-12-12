import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';

class ItemButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isActive;
  final String? trailing;
  const ItemButton({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isActive = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
              border: Border.all(
                  color: isActive ? AppColor.primaryColor : AppColor.lightgrey),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFEECED)),
                      child: Image(image: AssetImage(imagePath))),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        title,
                        style: AppTextStyle.body(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: AppTextStyle.body(size: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  trailing ?? '',
                  style: AppTextStyle.body(
                      size: 14,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
