import '../../../utils/app_color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final String hintText;
  final String validatorText;
  final String prefixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final bool enabled;
  final Color fillColor;
  final Function(String)? onTextChanged;
  final double radius;
  final int maxLines;
  final FocusNode? focusNode;
  final String? Function(String? value)? validator;

  const CommonTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.fillColor,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.onTextChanged,
    this.radius = 5,
    this.maxLines = 1,
    this.validatorText = "",
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppColor.primary,
      style: TextStyle(
        fontSize: AppSizes.setFontSize(15),
        fontWeight: FontWeight.w400,
        color: AppColor.primary,
        fontFamily: Constant.fontFamilyInter,
      ),
      maxLines: maxLines,
      onChanged: onTextChanged,
      enabled: enabled,
      validator: validator ??
          (String? value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            }
            return null;
          },
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: AppSizes.setFontSize(15),
          fontWeight: FontWeight.w400,
          color: AppColor.txtGrey,
          fontFamily: Constant.fontFamilyInter,
        ),
        errorStyle: TextStyle(
          fontSize: AppSizes.setFontSize(14),
          fontWeight: FontWeight.w400,
          color: AppColor.txtRed,
          fontFamily: Constant.fontFamilyInter,
        ),
        contentPadding: EdgeInsets.only(
          right: AppSizes.setWidth(15),
          top: (maxLines > 1) ? AppSizes.setHeight(14) : 0,
          bottom: (maxLines > 1) ? AppSizes.setHeight(14) : 0,
        ),
        prefixIcon: Container(
          //padding: EdgeInsets.all(AppSizes.setHeight(12)),
          padding: (maxLines > 2)
              ? EdgeInsets.only(bottom: AppSizes.setHeight(10), left: AppSizes.setHeight(12), right: AppSizes.setHeight(12), top: 0)
              : EdgeInsets.all(AppSizes.setHeight(12)),
          margin: EdgeInsets.only(
              top: 0,
              bottom: (maxLines > 1)
                  ? (maxLines == 2)
                      ? AppSizes.setHeight(15)
                      : AppSizes.setHeight(65)
                  : 0),
          child: Image.asset(
            prefixIcon,
            height: AppSizes.setHeight(25),
            width: AppSizes.setHeight(25),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
      ),
    );
  }
}

class CommonTextFormFieldWithSuffix extends StatelessWidget {
  final String hintText;
  final String validatorText;
  final String prefixIcon;
  final String suffixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final bool enabled;
  final Color fillColor;
  final Function(String)? onTextChanged;
  final double radius;
  final int maxLines;

  const CommonTextFormFieldWithSuffix({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.fillColor,
    this.keyboardType,
    this.suffixIcon = "",
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.onTextChanged,
    this.radius = 5,
    this.maxLines = 1,
    this.validatorText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppColor.primary,
      style: TextStyle(
        fontSize: AppSizes.setFontSize(15),
        fontWeight: FontWeight.w400,
        color: AppColor.primary,
        fontFamily: Constant.fontFamilyInter,
      ),
      maxLines: maxLines,
      onChanged: onTextChanged,
      enabled: enabled,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: AppSizes.setFontSize(15),
          fontWeight: FontWeight.w400,
          color: AppColor.txtGrey,
          fontFamily: Constant.fontFamilyInter,
        ),
        errorStyle: TextStyle(
          fontSize: AppSizes.setFontSize(14),
          fontWeight: FontWeight.w400,
          color: AppColor.txtRed,
          fontFamily: Constant.fontFamilyInter,
        ),
        contentPadding: EdgeInsets.only(
          right: AppSizes.setWidth(0),
          top: (maxLines > 1) ? AppSizes.setHeight(14) : 0,
          bottom: (maxLines > 1) ? AppSizes.setHeight(14) : 0,
        ),
        prefixIcon: Container(
          //padding: EdgeInsets.all(AppSizes.setHeight(12)),
          padding: (maxLines > 2)
              ? EdgeInsets.only(bottom: AppSizes.setHeight(10), left: AppSizes.setHeight(12), right: AppSizes.setHeight(12), top: 0)
              : EdgeInsets.all(AppSizes.setHeight(12)),
          margin: EdgeInsets.only(
              top: 0,
              bottom: (maxLines > 1)
                  ? (maxLines == 2)
                      ? AppSizes.setHeight(15)
                      : AppSizes.setHeight(65)
                  : 0),
          child: Image.asset(
            prefixIcon,
            height: AppSizes.setHeight(25),
            width: AppSizes.setHeight(25),
          ),
        ),
        suffixIcon: (suffixIcon != "")
            ? Padding(
                padding: EdgeInsets.all(AppSizes.setHeight(12)),
                child: Image.asset(
                  suffixIcon,
                  height: AppSizes.setHeight(25),
                  width: AppSizes.setHeight(25),
                ),
              )
            : const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
      ),
    );
  }
}

class CommonTextFormFieldWitOutPrefix extends StatelessWidget {
  final String hintText;
  final String validatorText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final bool enabled;
  final Color fillColor;
  final Function(String)? onTextChanged;
  final double radius;
  final int maxLines;

  const CommonTextFormFieldWitOutPrefix({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.fillColor,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.onTextChanged,
    this.radius = 5,
    this.maxLines = 1,
    this.validatorText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppColor.primary,
      style: TextStyle(
        fontSize: AppSizes.setFontSize(15),
        fontWeight: FontWeight.w400,
        color: AppColor.primary,
        fontFamily: Constant.fontFamilyInter,
      ),
      maxLines: maxLines,
      onChanged: onTextChanged,
      enabled: enabled,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: AppSizes.setFontSize(15),
          fontWeight: FontWeight.w400,
          color: AppColor.txtGrey,
          fontFamily: Constant.fontFamilyInter,
        ),
        errorStyle: TextStyle(
          fontSize: AppSizes.setFontSize(14),
          fontWeight: FontWeight.w400,
          color: AppColor.txtRed,
          fontFamily: Constant.fontFamilyInter,
        ),
        contentPadding: EdgeInsets.only(
          right: AppSizes.setWidth(12),
          left: AppSizes.setWidth(12),
          top: (maxLines > 1) ? AppSizes.setHeight(14) : 0,
          bottom: (maxLines > 1) ? AppSizes.setHeight(14) : 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColor.transparent),
        ),
      ),
    );
  }
}
