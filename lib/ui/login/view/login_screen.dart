

import '../../../generated/assets.dart';
import '../../../localization/language/languages.dart';
import '../../../ui/home/bloc/home_bloc.dart';
import '../../../ui/home/view/home_screen.dart';
import '../../../ui/login/bloc/login_bloc.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import '../../../utils/utils.dart';
import '../../../validator/email/email_validator.dart';
import '../../../widgets/components/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/text_field/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static Route<void> route(String? data) {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
              create: (_) => HomeBloc(),
              child: const HomeScreen(
                title: 'hello',
              ),
            ));
  }

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    emailTextEditingController.text = 'kminchelle';
    context.read<LoginBloc>().add(EmailTextChanged(emailTextEditingController.text));
    passwordTextEditingController.text = '0lelplR';
    context.read<LoginBloc>().add(PasswordTextChanged(passwordTextEditingController.text));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure && state.errorMessage.isNotEmpty) {
            // Show error message
            Utils.showSnackBar(context, state.errorMessage);
          }

          if (state.status.isSuccess) {
            Utils.showSnackBar(context, "Login Successfully", isSuccess: true);
            Navigator.pushAndRemoveUntil(context, LoginScreen.route(""), (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  Assets.imagesLoginDark,
                  fit: BoxFit.cover,
                ),
                Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back!",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      const Text(
                        "Log in with your data that you intered during your registration.",
                      ),
                      const SizedBox(height: defaultPadding),

                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: AppSizes.setWidth(25)),
                      //   child: CommonTextFormField(
                      //     controller: emailTextEditingController,
                      //     enabled: !state.status.isLoading,
                      //     hintText: Languages.of(context).txtHintEnterYourEmail,
                      //     prefixIcon: state.emailPrefixIcon,
                      //     onTextChanged: (value) => context.read<LoginBloc>().add(EmailTextChanged(value)),
                      //     fillColor: state.emailBgColor,
                      //     keyboardType: TextInputType.emailAddress,
                      //     //validator: emailValidator,
                      //     validatorText: Languages.of(context).txtEmailRequired,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: AppSizes.setWidth(25)),
                      //   child: CommonTextFormField(
                      //     controller: passwordTextEditingController,
                      //     enabled: !state.status.isLoading,
                      //     hintText: Languages.of(context).txtHintEnterYourPassword,
                      //     prefixIcon: state.passPrefixIcon,
                      //     onTextChanged: (value) => context.read<LoginBloc>().add(PasswordTextChanged(value)),
                      //     fillColor: state.passBgColor,
                      //     keyboardType: TextInputType.visiblePassword,
                      //     validatorText: Languages.of(context).txtPasswordRequired,
                      //   ),
                      // ),
                      LogInForm(
                        formKey: formKey,
                        enabled: !state.status.isLoading,
                        onEmailTextChanged:(value) => context.read<LoginBloc>().add(EmailTextChanged(value)),
                        onPassTextChanged: (value) => context.read<LoginBloc>().add(PasswordTextChanged(value)),

                      ),
                      Align(
                        child: TextButton(
                          child: const Text("Forgot password"),
                          onPressed: () {
                            // Navigator.pushNamed(
                            //     context, passwordRecoveryScreenRoute);
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height > 700
                            ? size.height * 0.1
                            : defaultPadding,
                      ),
                      ElevatedButton(
                        onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<LoginBloc>()
                                  .add(LoginButtonPressed(emailTextEditingController.text.trim(), passwordTextEditingController.text.trim()));
                            }
                        },
                        child: const Text("Log in"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, signUpScreenRoute);
                            },
                            child: const Text("Sign up"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                /*Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.setWidth(25)),
                  child: CommonTextFormField(
                    controller: emailTextEditingController,
                    enabled: !state.status.isLoading,
                    hintText: Languages.of(context).txtHintEnterYourEmail,
                    prefixIcon: state.emailPrefixIcon,
                    onTextChanged: (value) => context.read<LoginBloc>().add(EmailTextChanged(value)),
                    fillColor: state.emailBgColor,
                    keyboardType: TextInputType.emailAddress,
                    //validator: emailValidator,
                    validatorText: Languages.of(context).txtEmailRequired,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.setWidth(25)),
                  child: CommonTextFormField(
                    controller: passwordTextEditingController,
                    enabled: !state.status.isLoading,
                    hintText: Languages.of(context).txtHintEnterYourPassword,
                    prefixIcon: state.passPrefixIcon,
                    onTextChanged: (value) => context.read<LoginBloc>().add(PasswordTextChanged(value)),
                    fillColor: state.passBgColor,
                    keyboardType: TextInputType.visiblePassword,
                    validatorText: Languages.of(context).txtPasswordRequired,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                (state.status.isLoading)
                    ? Container(
                        height: AppSizes.setHeight(46),
                        width: AppSizes.fullWidth,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: AppSizes.setWidth(45), right: AppSizes.setWidth(45), top: AppSizes.setHeight(38), bottom: AppSizes.setHeight(53)),
                        child: const CircularProgressIndicator(
                          strokeWidth: 3.0,
                          color: AppColor.primary,
                        ),
                      )
                    : CommonButton(
                        height: AppSizes.setHeight(46),
                        width: AppSizes.fullWidth,
                        alignment: Alignment.center,
                        mLeft: AppSizes.setWidth(45),
                        mRight: AppSizes.setWidth(45),
                        mTop: AppSizes.setHeight(38),
                        mBottom: AppSizes.setHeight(53),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<LoginBloc>()
                                .add(LoginButtonPressed(emailTextEditingController.text.trim(), passwordTextEditingController.text.trim()));
                          }
                        },
                        child: CommonText(
                          text: Languages.of(context).txtLogin.toUpperCase(),
                          textColor: AppColor.txtWhite,
                          fontSize: AppSizes.setFontSize(15),
                        ),
                      ),
                SizedBox(
                  height: 130,
                ),
                Text('New User? Create Account')*/
              ],
            ),
          );
        },
      ),
    );
  }

  String? emailValidator(String? value) {
    if (emailTextEditingController.text.trim().isEmpty) {
      return Languages.of(context).txtEmailRequired;
    } else if (!EmailValidator.validate(emailTextEditingController.text.trim(), true)) {
      return Languages.of(context).txtEmailInvalid;
    }
    return null;
  }
}
