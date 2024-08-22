import '../../../generated/assets.dart';
import '../../../localization/language/languages.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../validator/email/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/view/home_screen.dart';
import '../bloc/signup_bloc.dart';
import 'components/sign_up_form.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
              create: (_) => SignupBloc(),
              child: const SignUpScreen(),
            ));
  }

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status.isFailure && state.errorMessage.isNotEmpty) {
            // Show error message
            Utils.showSnackBar(context, state.errorMessage);
          }

          if (state.status.isSuccess) {
            Utils.showSnackBar(context, "SignUp Successfully", isSuccess: true);
            Navigator.pushAndRemoveUntil(context, HomeScreen.route(""), (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  Assets.imagesSignUpDark,
                  fit: BoxFit.cover,
                ),
                Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let’s get started!",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      const Text(
                        "Please enter your valid data in order to create an account.",
                      ),
                      const SizedBox(height: defaultPadding),

                      SignUpForm(
                        formKey: formKey,
                        enabled: !state.status.isLoading,
                        emailTextEditingController:emailTextEditingController,
                        userNameTextEditingController:userNameTextEditingController,
                        passwordTextEditingController: passwordTextEditingController
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Login"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height > 700
                            ? size.height * 0.1
                            : defaultPadding,
                        child:state.status.isLoading?const Center(child: CircularProgressIndicator()):null,
                      ),

                      ElevatedButton(
                        onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<SignupBloc>()
                                  .add(SignUpButtonPressed(emailTextEditingController.text.trim(),userNameTextEditingController.text.trim() ,passwordTextEditingController.text.trim()));
                            }
                        },
                        child: const Text("Sign Up"),
                      ),

                    ],
                  ),
                ),
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
