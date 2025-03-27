import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';

class item_image extends StatelessWidget {
  final Widget? item;
  final double? width;
  final VoidCallback? onTap;
  const item_image({
    super.key,
    this.item,
    this.width,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DottedBorder(
      color: AppColor.bordergrey, // Color of the dots
      strokeWidth: 5, // Thickness of the dots
      borderType: BorderType.RRect, // Rectangle with rounded corners
      radius: const Radius.circular(12), // Radius of the corners
      dashPattern: const [6, 3], // Dash and gap lengths
      child: Container(
          width: width ?? size.width * 0.8,
          height: size.height * 0.07,
          alignment: Alignment.center,
          child: item ??
              GestureDetector(
                onTap: onTap,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, color: Colors.red),
                    SizedBox(width: 40),
                    Text(
                      "Upload Image",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: AppColor.dark,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
    );
  }
}

class selected_image extends StatelessWidget {
  final Widget? item;
  final double? width;
  final VoidCallback? onTap;
  const selected_image({
    super.key,
    this.item,
    this.width,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width * 0.8,
      margin: const EdgeInsets.all(5.0),
      height: size.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.grey, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
      ),
      padding: const EdgeInsets.all(4.0), // Add some padding
      child: item ??
          GestureDetector(
            onTap: onTap,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add_circle, color: Colors.red),
                SizedBox(width: 40),
                Text(
                  "Upload Image",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.dark,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
    );

    // DottedBorder(
    //   color: AppColor.bordergrey, // Color of the dots
    //   strokeWidth: 5, // Thickness of the dots
    //   borderType: BorderType.RRect, // Rectangle with rounded corners
    //   radius: Radius.circular(12), // Radius of the corners
    //   dashPattern: [6, 3], // Dash and gap lengths
    //   child: Container(
    //       width: width?? size.width * 0.8,
    //       height: size.height * 0.07,
    //       alignment: Alignment.center,
    //       child: item ??
    //           GestureDetector(
    //             onTap: onTap,
    //             child: const Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.max,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                  Icon(Icons.add_circle, color: Colors.red),
    //                  SizedBox(width: 40),
    //                  Text(
    //                   "Upload Image",
    //                   style: TextStyle(
    //                       fontSize: 16.0,
    //                       color: AppColor.dark,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ],
    //             ),
    //           )),
    // );
  }
}
