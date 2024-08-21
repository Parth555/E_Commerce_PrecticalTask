import '../../../utils/app_color.dart';
import '../../../utils/sizer_utils.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Color buttonColor;
  final double? height;
  final double? width;
  final double radius;
  final double mTop;
  final double mBottom;
  final double mLeft;
  final double mRight;
  final double pVertical;
  final double pHorizontal;
  final Widget child;
  final Alignment alignment;
  final Function()? onTap;

  const CommonButton({
    super.key,
    required this.child,
    this.buttonColor = AppColor.primary,
    this.alignment = Alignment.center,
    this.radius = 5,
    this.height,
    this.width,
    this.mTop = 0,
    this.mBottom = 0,
    this.mLeft = 0,
    this.mRight = 0,
    this.pVertical = 0,
    this.pHorizontal = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height ?? AppSizes.setHeight(50),
          width: width ?? AppSizes.setWidth(100),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: pVertical,
            horizontal: pHorizontal,
          ),
          margin: EdgeInsets.only(
            top: mTop,
            bottom: mBottom,
            left: mLeft,
            right: mRight,
          ),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: child,
        ),
      ),
    );
  }
}
