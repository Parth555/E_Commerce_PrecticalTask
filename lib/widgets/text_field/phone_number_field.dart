import 'dart:async';

import '../../../utils/app_color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import '../../../widgets/phone_field/countries.dart';
import '../../../widgets/phone_field/country_picker_dialog.dart';
import '../../../widgets/phone_field/intl_phone_field.dart';
import '../../../widgets/phone_field/phone_number.dart';
import 'package:flutter/material.dart';

class PhoneNumberTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String prefixIcon;
  final String initialCountryCode;
  final bool enabled;
  final Color fillColor;
  final Function(PhoneNumber)? onTextChanged;
  final Function(Country)? onCountryChange;
  final double radius;
  final int maxLines;
  final bool obscureText;
  final bool autofocus;
  final FocusNode? focusNode;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final String? invalidNumberMessage;
  final Key? formKey;

  const PhoneNumberTextField({
    Key? key,
    this.formKey,
    required this.controller,
    required this.hintText,
    required this.fillColor,
    required this.prefixIcon,
    this.initialCountryCode = Constant.countryCodeForPhoneNumber,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.onTextChanged,
    this.onCountryChange,
    this.radius = 5,
    this.maxLines = 1,
    this.focusNode,
    this.validator,
    this.invalidNumberMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: TextStyle(
        fontSize: AppSizes.setFontSize(15),
        fontWeight: FontWeight.w400,
        color: AppColor.primary,
        fontFamily: Constant.fontFamilyInter,
      ),
      enabled: enabled,
      focusNode: focusNode,
      autofocus: autofocus,
      obscureText: obscureText,
      cursorColor: AppColor.primary,
      disableLengthCheck: true,
      flagsButtonPadding: enabled ? EdgeInsets.zero : EdgeInsets.only(left: AppSizes.setWidth(10)),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        //counter: Container(),
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
          top: AppSizes.setHeight(14),
          bottom: AppSizes.setHeight(14),
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
      controller: controller,
      initialCountryCode: initialCountryCode,
      dropdownTextStyle: TextStyle(
        fontSize: AppSizes.setFontSize(15),
        fontWeight: FontWeight.w400,
        color: AppColor.primary,
        fontFamily: Constant.fontFamilyInter,
      ),
      onCountryChanged: onCountryChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: AppColor.primaryBackground,
        countryCodeStyle: TextStyle(
          fontSize: AppSizes.setFontSize(15),
          fontWeight: FontWeight.w400,
          color: AppColor.primary,
          fontFamily: Constant.fontFamilyInter,
        ),
        countryNameStyle: TextStyle(
          fontSize: AppSizes.setFontSize(15),
          fontWeight: FontWeight.w400,
          color: AppColor.primary,
          fontFamily: Constant.fontFamilyInter,
        ),
      ),
      onChanged: onTextChanged,
      invalidNumberMessage: invalidNumberMessage,

      /// validator: validator,
    );
  }
}
