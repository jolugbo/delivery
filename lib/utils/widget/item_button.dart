import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';

class ItemButton extends StatelessWidget {
  String iconPath;
  String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isActive;
  final String? trailing;
  ItemButton({
    super.key,
    this.iconPath = "",
    this.imagePath = "",
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isActive = false,
    this.trailing,
  });
  final Map<String, IconData> iconMap = {
    "local_shipping": Icons.local_shipping,
    "home_work": Icons.home_work,
    "location_on": Icons.location_on,
    "route": Icons.route,
    "public": Icons.public,
    "flight_takeoff": Icons.flight_takeoff,
  };
  IconData getIconFromType(String iconType) {
    return iconMap[iconType] ??
        Icons.help_outline; // Fallback to a default icon
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final String iconType = iconPath;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: isActive ? AppColor.primaryColor : AppColor.lightgrey),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFEECED)),
                      child: iconType != ""
                          ? Icon(getIconFromType(iconType),
                              size: 18, color: AppColor.primaryColor)
                          : Image(
                              image: AssetImage(
                                  imagePath))), // Icon(local_shipping)),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        width: size.width * 0.5,
                        child: Text(
                          title,
                          style: AppTextStyle.body(
                              fontWeight: FontWeight.bold,
                              size: 16,
                              color: AppColor.dark),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        width: size.width * 0.5,
                        child: Text(
                          subtitle,
                          style: AppTextStyle.body(
                              size: 15,
                              fontWeight: FontWeight.normal,
                              color: AppColor.dark),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
