import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/modules/login/welcome_back.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/app_text_fields.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:provider/provider.dart';

class SetNewPassword extends StatefulWidget {
  final String emailOrPhone;
  final String pin;
  final String channel;
  final String accountTYpe;
  const SetNewPassword(
      {super.key,
      required this.emailOrPhone,
      required this.pin,
      required this.channel,
      required this.accountTYpe});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  bool showSuccessOverlay = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isFormValid = false;

  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }
  void showCustomPrompt(BuildContext context, String msg) {
  showDialog(
    context: context,
    barrierDismissible: true, // Close the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text("Error",
          style: AppTextStyle.body(
                          size: 16, fontWeight: FontWeight.bold),),
          content: Text(msg,
          style: AppTextStyle.body(
                          size: 14, fontWeight: FontWeight.w400),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      
    },
  );
}


  Future<void> resetPassword(AuthProvider authProvider) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });
      var response = await authProvider.resetPassword(
        emailOrPhone: widget.emailOrPhone,
        newPassword: passwordEditingController.text,
        confirmPassword: cpasswordController.text,
        channel: widget.channel,
        token: widget.pin,
        accountType: widget.accountTYpe,
      );

      setState(() {
        isLoading = false;
      });

      if (response['success']) {
        setState(() {
          showSuccessOverlay = true;
        });
      } else {
        print("Reset Password failed: ${response['message']}");
        showCustomPrompt(context,response['message']);
        //Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        body: Stack(
            //overflow: Overflow.visible,
            children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const GoBackButtton(
                      iconColor: AppColor.black,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Set new Password',
                      style: AppTextStyle.body(
                          size: 27, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create a new 8 digit password',
                      style: AppTextStyle.body(size: 14),
                    ),
                    Form(
                      key: _formKey,
                      onChanged: _validateForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Text('Password',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 8),
                          AppTextFields(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return 'Password must have at least one uppercase letter';
                              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Password must have at least one digit';
                              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                  .hasMatch(value)) {
                                return 'Password must have at least one special character';
                              }
                              return null;
                            },
                            controller: passwordEditingController,
                            hint: 'Enter Your Password',
                            isPassword: true,
                          ),
                          const SizedBox(height: 10),
                          Text('Confirm Password',
                              style: AppTextStyle.body(
                                  size: 14, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 8),
                          AppTextFields(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password cannot be empty';
                              } else if (value !=
                                  passwordEditingController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            controller: cpasswordController,
                            hint: 'Enter Your Password',
                            isPassword: true,
                          ),
                          const SizedBox(height: 50),
                          AppButton(
                              title: 'Set New Password',
                              color: isFormValid
                                  ? AppColor.primaryColor
                                  : AppColor.grey,
                              onTap: () => resetPassword(authProvider)),
                        ],
                      ),
                    ),
                  ])),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          if (showSuccessOverlay)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showSuccessOverlay = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 350,
                          height: 450,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            const SizedBox(height: 50), // Space for the close button
                            Image(
                              image: AssetImage(AppImages.lock),
                              height: 100,
                            ),
                            // Icon(Icons.check_circle,
                            //     color: Colors.green, size: 60),
                            const SizedBox(height: 50),
                            Text(
                              'Password change successful',
                              style: AppTextStyle.body(
                                  size: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Your password has successfully been changed. Login with the new password',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.body(
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.lightdark),
                            ),
                            const SizedBox(height: 40),
                            AppButton(
                                title: 'Back to Login',
                                color: AppColor.primaryColor,
                                onTap: () => {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WelcomeBack()),
                                        (Route<dynamic> route) =>
                                            false, // Remove all previous routes
                                      )
                                    }),
                          ]),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomeBack()),
                                (Route<dynamic> route) =>
                                    true, // Remove all previous routes
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // Ensures the circular shape
                                color: Colors.white, // White background
                                border: Border.all(
                                  color:
                                      Colors.grey.shade300, // Light grey border
                                  width: 1.5, // Thin border
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.close, // "X" icon
                                  color:
                                      AppColor.dark, // Black color for the icon
                                  size: 18, // Small icon size
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ]));
  }
}
