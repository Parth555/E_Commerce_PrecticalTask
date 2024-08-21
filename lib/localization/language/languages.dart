import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages)!;
  }

  String get txtWhoops;

  String get txtNoInternetConnection;

  String get txtDescNoInternetConnection;

  String get toastPleaseCheckYourInternetConnection;

  String get txtTryAgain;

  String get txtHintEnterYourEmail;

  String get txtEmailRequired;

  String get txtEmailInvalid;

  String get txtHintEnterYourPassword;

  String get txtPasswordRequired;

  String get txtPasswordInvalid;

  String get txtLogin;

  String get txtPushButtonTimeMsg;

  String get txtSelectLanguage;

  String get txtGoToSplash;

  String get txtLinearTweenAnim;

  String get txtEaseInOutTweenAnim;

  String get txtBezierTweenAnim;

  String get txtAnimatedList;

  String get txtAnimatedGridView;
}
