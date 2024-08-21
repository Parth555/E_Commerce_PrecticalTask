import '../../../localization/language/languages.dart';
import '../../../localization/locale_constant.dart';
import '../../../ui/home/bloc/home_bloc.dart';
// import '../../../ui/pagination_list_screen/bloc/second_bloc.dart';
// import '../../../ui/pagination_list_screen/view/second_screen.dart';
// import '../../../ui/product_list/view/product_list_screen.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/debug.dart';
import '../../../utils/sizer_utils.dart';
import '../../../widgets/button/common_button.dart';
import '../../../widgets/photo_hero/PhotoHero.dart';
import '../../../widgets/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _heightAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    )..addListener(() {
        Debug.printLog("HEight ==> ${_heightAnimation?.value}");
        context.read<HomeBloc>().add(AnimationChange(height: _heightAnimation?.value));
        //context.read<HomeBloc>().emit(context.read<HomeBloc>().state.copyWith(height: _heightAnimation?.value));
      });

    _heightAnimation = Tween(begin: 80.0, end: 280.0).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));

    super.initState();
  }

  void _incrementCounter() {
    context.read<HomeBloc>().add(Increment());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          InkWell(
              onTap: () {
                _showLanguageChangeDialog();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.language_rounded,
                  size: AppSizes.setHeight(25),
                ),
              ))
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          Debug.printLog("state HEight ==> ${state.height}");

          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage()));
                      if (!state.isFullImage)
                        _controller?.forward();
                      else
                        _controller?.reverse();

                      context.read<HomeBloc>().add(AnimationChange());
                    },
                    child: Container(
                      height: AppSizes.setHeight(_heightAnimation!.value),
                      width: AppSizes.fullWidth,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: AssetImage(
                              AppAssets.bg1,
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: !state.isFullImage
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 20),
                                  Hero(
                                    tag: AppAssets.pneuma_circle,
                                    child: Image.asset(
                                      AppAssets.pneuma_circle,
                                      height: AppSizes.setHeight(60),
                                      width: AppSizes.setHeight(60),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  CommonText(
                                    text: "Pneuma".toUpperCase(),
                                    textColor: AppColor.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSizes.setFontSize(30),
                                  )
                                ],
                              )
                            : (_heightAnimation!.value == 280)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Hero(
                                        tag: AppAssets.pneuma_circle,
                                        child: Image.asset(
                                          AppAssets.pneuma,
                                          height: AppSizes.setHeight(100),
                                          width: AppSizes.setHeight(100),
                                        ),
                                      ),
                                      CommonText(
                                        text: "Pneuma".toUpperCase(),
                                        textColor: AppColor.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppSizes.setFontSize(30),
                                      )
                                    ],
                                  )
                                : SizedBox(),
                      ),
                    ) /*ClipRRect(
                      //borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        AppAssets.bg1,
                        height: AppSizes.setHeight(_heightAnimation?.value),
                        width: AppSizes.fullWidth - 100,
                        fit: (_heightAnimation?.value == 50) ? BoxFit.cover : BoxFit.fitWidth,
                      ),
                    )*/
                    ,
                  ),
                  PhotoHero(
                    photo: AppAssets.bg1,
                    height: AppSizes.setHeight(50),
                    width: AppSizes.setHeight(50),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage()));
                      //context.read<HomeBloc>().add(ToggleImageView());
                    },
                  ),
                  CommonButton(
                    height: AppSizes.setHeight(46),
                    width: AppSizes.fullWidth,
                    alignment: Alignment.center,
                    mLeft: AppSizes.setWidth(45),
                    mRight: AppSizes.setWidth(45),
                    mTop: AppSizes.setHeight(38),
                    mBottom: AppSizes.setHeight(20),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
                    },
                    child: CommonText(
                      text: Languages.of(context).txtGoToSplash.toUpperCase(),
                      textColor: AppColor.txtWhite,
                      fontSize: AppSizes.setFontSize(15),
                    ),
                  ),
                  CommonButton(
                    height: AppSizes.setHeight(46),
                    width: AppSizes.fullWidth,
                    alignment: Alignment.center,
                    mLeft: AppSizes.setWidth(45),
                    mRight: AppSizes.setWidth(45),
                    mTop: AppSizes.setHeight(10),
                    mBottom: AppSizes.setHeight(20),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute<void>(
                      //         builder: (_) => BlocProvider(
                      //               create: (_) => SecondBloc()..add(const GetData(startPage: 0, endPage: 20)),
                      //               child: SecondScreen(),
                      //             )));
                    },
                    child: CommonText(
                      text: "Product List With Pagination",
                      textColor: AppColor.txtWhite,
                      fontSize: AppSizes.setFontSize(15),
                    ),
                  ),
                  CommonButton(
                    height: AppSizes.setHeight(46),
                    width: AppSizes.fullWidth,
                    alignment: Alignment.center,
                    mLeft: AppSizes.setWidth(45),
                    mRight: AppSizes.setWidth(45),
                    mTop: AppSizes.setHeight(10),
                    mBottom: AppSizes.setHeight(20),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen()));
                    },
                    child: CommonText(
                      text: "Product List",
                      textColor: AppColor.txtWhite,
                      fontSize: AppSizes.setFontSize(15),
                    ),
                  ),
                  CommonButton(
                    height: AppSizes.setHeight(46),
                    width: AppSizes.fullWidth,
                    alignment: Alignment.center,
                    mLeft: AppSizes.setWidth(45),
                    mRight: AppSizes.setWidth(45),
                    mTop: AppSizes.setHeight(10),
                    mBottom: AppSizes.setHeight(20),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentScannerScreen()));
                    },
                    child: CommonText(
                      text: "Document Scanner",
                      textColor: AppColor.txtWhite,
                      fontSize: AppSizes.setFontSize(15),
                    ),
                  ),
                  CommonButton(
                    height: AppSizes.setHeight(46),
                    width: AppSizes.fullWidth,
                    alignment: Alignment.center,
                    mLeft: AppSizes.setWidth(45),
                    mRight: AppSizes.setWidth(45),
                    mBottom: AppSizes.setHeight(10),
                    onTap: () {
                      // Navigator.push(context, AnimationExampleScreen.createRoute());
                    },
                    child: CommonText(
                      text: "Animation Example",
                      textColor: AppColor.txtWhite,
                      fontSize: AppSizes.setFontSize(15),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    Languages.of(context).txtPushButtonTimeMsg,
                  ),
                  Text(
                    '${state.value}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _showLanguageChangeDialog() async {
    String _selectedOption = (await getLocale()).languageCode;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return AlertDialog(
              title: Text(Languages.of(context).txtSelectLanguage),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    RadioListTile(
                      value: 'en',
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        if (value != null) {
                          state(() {
                            _selectedOption = value;
                          });
                        }
                      },
                      title: Text('English'),
                    ),
                    RadioListTile(
                      value: 'hi',
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        if (value != null) {
                          state(() {
                            _selectedOption = value;
                          });
                        }
                      },
                      title: Text('हिंदी'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(_selectedOption);
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(_selectedOption);
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        changeLanguage(context, value);
      }
    });
  }
}
