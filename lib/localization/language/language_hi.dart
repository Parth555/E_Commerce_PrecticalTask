import 'languages.dart';

class LanguageHi extends Languages {
  @override
  String get toastPleaseCheckYourInternetConnection => 'कृपया अपनी इंटरनेट कनेक्टिविटी सेटिंग्स जांचें';

  @override
  String get txtDescNoInternetConnection => "ऐसा लगता है कि आप इंटरनेट से कनेक्ट नहीं हैं. कृपया अपनी नेटवर्क सेटिंग जांचें।";

  @override
  String get txtNoInternetConnection => "कोई इंटरनेट कनेक्शन नहीं";

  @override
  String get txtTryAgain => "पुनः प्रयास करें";

  @override
  String get txtWhoops => "ओह";

  @override
  String get txtEmailInvalid => "अमान्य ईमेल";

  @override
  String get txtEmailRequired => "ईमेल अनिवार्य";

  @override
  String get txtHintEnterYourEmail => "अपना ईमेल दर्ज करें";

  @override
  String get txtHintEnterYourPassword => "अपना पासवर्ड दर्ज करें";

  @override
  String get txtPasswordInvalid => "अवैध पासवर्ड";

  @override
  String get txtPasswordRequired => "पासवर्ड आवश्यक";

  @override
  String get txtLogin => "लॉग इन करें";

  @override
  String get txtPushButtonTimeMsg => "आपने कितनी बार बटन दबाया है:";

  @override
  String get txtSelectLanguage => "भाषा चुने";

  @override
  String get txtGoToSplash => "Go To Splash";

  @override
  String get txtEaseInOutTweenAnim => "Ease In/Ease Out Tweening";

  @override
  String get txtLinearTweenAnim => "Linear Tweening";

  @override
  String get txtBezierTweenAnim => "Bezier Tweening";

  @override
  String get txtAnimatedList => "Animated List";

  @override
  String get txtAnimatedGridView => "Animated GridView";
}
