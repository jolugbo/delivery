import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gt_delivery/core/models/enumerators/button.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final String? buttonText;
  final ButtonType buttonType;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double borderWidth;
  final double? verticalPadding;
  final TextStyle? textStyle;
  final double? radius;
  final double? fontSize;
  final bool enabled;
  const AppButton(
      {super.key,
      this.child,
      this.radius,
      this.color,
      this.textColor,
      this.buttonText,
      this.borderWidth = 1,
      this.borderColor,
      this.buttonType = ButtonType.primary,
      this.onPressed,
      this.fontSize,
      this.enabled = false,
      this.verticalPadding,
      this.textStyle})
      : assert(buttonText != null || child != null);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key ?? (buttonText == null ? UniqueKey() : ValueKey(buttonText!)),
      onPressed: () {
        if (onPressed != null) {
          FocusScope.of(context).unfocus();
          onPressed!();
        }
      },
      style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double>((states) => 0),
        padding: WidgetStateProperty.resolveWith<EdgeInsets>(
          (states) => EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h),
        ),
        fixedSize: WidgetStateProperty.resolveWith<Size>(
          (states) => Size(335.w, 48.h),
        ),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
          (states) => RoundedRectangleBorder(
            side: BorderSide(
              color: onPressed == null ? Colors.transparent : borderColor ?? color ?? buttonType.borderColor,
              width: borderWidth,
            ),
            borderRadius: BorderRadius.circular(radius ?? 25.r),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled) || onPressed == null) {
              return buttonType.disabledColor;
            }
            return color ?? buttonType.buttonColor; // Use the component's default.
          },
        ),
      ),
      child: child ??
          Text(
            buttonText!,
            style: textStyle ??
                TextStyle(
                  fontSize: fontSize ?? 12.sp,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  //fontFamily: buttonText!.contains('₦') ? '' : FontFamily.hankenGrotesk,
                  color: textColor ?? buttonType.textColor,
                ),
          ),
    );
  }
}
