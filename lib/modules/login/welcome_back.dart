import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/modules/create_account/create_account.dart';
import 'package:gt_delivery/modules/forgot_password/forgot_password.dart';
import 'package:gt_delivery/modules/home/home.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/app_text_fields.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:provider/provider.dart';

class WelcomeBack extends StatefulWidget {
  const WelcomeBack({super.key});

  @override
  State<WelcomeBack> createState() => _WelcomeBackState();
}

class _WelcomeBackState extends State<WelcomeBack> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isFormValid = false;

  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> loginUser(AuthProvider authProvider) async {
    if (isFormValid) {
      setState(() {
        isLoading = true;
      }); 

      final response = await authProvider.login(
          usernameOrPhoneNumber: emailController.text, //"usr1",//
          password: passwordController.text); //"@Ssess123");//

      setState(() {
        isLoading = false;
      });

      if (response['success']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      token: response["data"]["resultData"]["accessToken"],
                      userId: response["data"]["resultData"]["userName"],
                    )));
      } else {
        print("Signin failed: ${response["message"]}");
        CustomSnackbar.showError(
            context, response['data']["message"] ?? response['message']);
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Form Input.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        body: Stack(
          children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const GoBackButtton(
                      iconColor: AppColor.black,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Welcome Back!',
                          style: AppTextStyle.body(
                              size: 27, fontWeight: FontWeight.bold),
                        ),
                        Image(image: AssetImage(AppImages.wave)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lets get you back on to sending packages',
                      style: AppTextStyle.body(size: 14),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      onChanged:
                          _validateForm, // Revalidate form on any field change
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: AppTextStyle.body(
                                size: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          AppTextFields(
                            controller: emailController,
                            hint: 'Enter your username',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'username is required';
                              }
                              // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              //   return 'Enter a valid email address';
                              // }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Password',
                            style: AppTextStyle.body(
                                size: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          AppTextFields(
                            controller: passwordController,
                            hint: 'Enter your password',
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyle.body(
                                    color: AppColor.primaryColor,
                                    size: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          AppButton(
                            title: 'Sign In',
                            color: isFormValid
                                ? AppColor.primaryColor
                                : AppColor.grey,
                            onTap: () => loginUser(
                                authProvider), // Disable the button if the form is invalid
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Text('Or continue with',
                            style: AppTextStyle.body(
                                color: AppColor.lightdark, size: 14)),
                        const Expanded(child: Divider())
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.lightdark),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage(AppImages.google)),
                          const SizedBox(width: 10),
                          Text(
                            'Sign in with Google',
                            style:
                                AppTextStyle.body(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.lightdark),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage(AppImages.apple)),
                          const SizedBox(width: 10),
                          Text(
                            'Sign in with Apple',
                            style:
                                AppTextStyle.body(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'Don\'t have an account?  ',
                            style: AppTextStyle.body(size: 14),
                          ),
                          TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAccount()));
                                },
                              style: AppTextStyle.body(
                                  fontWeight: FontWeight.bold,
                                  size: 15,
                                  color: AppColor.primaryColor)),
                        ])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
        ]));
  }
}
