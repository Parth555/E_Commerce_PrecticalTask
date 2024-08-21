import '../../../interfaces/top_bar_click_listener.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import '../../../widgets/button/common_button.dart';
import '../../../widgets/text/common_text.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar(
    this.clickListener, {
    super.key,
    required this.title,
    this.isShowBack = true,
    this.isShowAddKudos = false,
    this.isShowCall = false,
  });

  final String title;
  final bool isShowBack;
  final bool isShowAddKudos;
  final bool isShowCall;
  final TopBarClickListener clickListener;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: AppSizes.setHeight(15),
        bottom: AppSizes.setHeight(10),
        left: AppSizes.setWidth(25),
        right: AppSizes.setWidth(25),
      ),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: AppSizes.setWidth(45), right: AppSizes.setWidth(25)),
            child: CommonText(
              text: title,
              maxLines: 1,
              fontFamily: Constant.fontFamilyInriaSans,
              fontSize: AppSizes.setFontSize(20),
            ),
          ),
          if (isShowBack) ...{
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: AppSizes.setHeight(40),
                width: AppSizes.setHeight(40),
                child: CommonButton(
                  height: AppSizes.setHeight(40),
                  width: AppSizes.setHeight(40),
                  alignment: Alignment.centerLeft,
                  buttonColor: AppColor.secondaryBackground,
                  pHorizontal: AppSizes.setHeight(7.5),
                  pVertical: AppSizes.setHeight(7.5),
                  onTap: () {
                    clickListener.onTopBarClick(Constant.strBack);
                  },
                  child: Image.asset(AppAssets.icBack),
                ),
              ),
            ),
          },
          if (isShowAddKudos) ...{
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: AppSizes.setHeight(40),
                width: AppSizes.setHeight(40),
                child: CommonButton(
                  alignment: Alignment.centerRight,
                  height: AppSizes.setHeight(40),
                  width: AppSizes.setHeight(40),
                  buttonColor: AppColor.secondaryBackground,
                  pHorizontal: AppSizes.setHeight(7.5),
                  pVertical: AppSizes.setHeight(7.5),
                  onTap: () {
                    clickListener.onTopBarClick(Constant.strAdd);
                  },
                  child: Image.asset(AppAssets.icAddContact),
                ),
              ),
            ),
          },
          if (isShowCall) ...{
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: AppSizes.setHeight(40),
                width: AppSizes.setHeight(40),
                child: CommonButton(
                  alignment: Alignment.centerRight,
                  height: AppSizes.setHeight(40),
                  width: AppSizes.setHeight(40),
                  buttonColor: AppColor.secondaryBackground,
                  pHorizontal: AppSizes.setHeight(7.5),
                  pVertical: AppSizes.setHeight(7.5),
                  onTap: () {
                    clickListener.onTopBarClick(Constant.strCall);
                  },
                  child: Image.asset(
                    AppAssets.icCallUnSelected,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}
