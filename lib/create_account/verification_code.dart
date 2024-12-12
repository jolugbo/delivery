// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gt_delivery/core/custom_snackbar.dart';
import 'package:gt_delivery/create_account/security_question.dart';
import 'package:gt_delivery/provider/auth_provider.dart';
import 'package:gt_delivery/widget/back_button.dart';
import 'package:gt_delivery/widget/loading.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/textstyles/text_styles.dart';
import 'package:gt_delivery/widget/app_button.dart';
import 'package:provider/provider.dart';

class VerificationCode extends StatefulWidget {
  final String emailOrPhone;
  final String userId;
  final String channel;
  const VerificationCode({
    super.key,
    required this.emailOrPhone,
    required this.userId,
    required this.channel,
  });

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  int time = 60;
  Timer? _timer;
  // List of controllers for each TextField
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  // List of focus nodes for each TextField
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  String pin = "";
  bool isLoarding = false;

  void startTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        _timer?.cancel();
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: isLoarding
          ? Loading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  GoBackButtton(
                    iconColor: AppColor.black,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Verification Code',
                    style: AppTextStyle.body(
                        size: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the 6-digit code we sent to ${widget.emailOrPhone}',
                    style: AppTextStyle.body(size: 14),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value != null || value!.isEmpty) {
                              return "All The field is Reqired";
                            } else {
                              return null;
                            }
                          },
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor)),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              // Move to the next field
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index + 1]);
                            } else if (value.isEmpty && index > 0) {
                              // Move to the previous field if the current is cleared
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index - 1]);
                            }
                            setState(() {
                              pin = _controllers
                                  .map((controller) => controller.text)
                                  .join();
                              print("Entered PIN: $pin");
                            });
                          },
                        ),
                      );
                    }),
                  ),
                  // PinCodeTextField(
                  //   pinTextStyle: AppTextStyle.body(),
                  //   keyboardType: TextInputType.number,
                  //   maxLength: 6,
                  //   pinBoxRadius: 10,
                  //   pinBoxColor: const Color.fromARGB(13, 255, 255, 255),
                  //   pinBoxWidth: 55,
                  //   pinBoxHeight: 60,
                  //   defaultBorderColor: AppColor.lightgrey,
                  //   hasTextBorderColor: AppColor.primaryColor,
                  //   onTextChanged: (ss) {
                  //     // setState(() {
                  //     //   codeController = ss;
                  //     // });
                  //   },
                  // ),
                  SizedBox(height: 20),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'You can resend the code in  ',
                      style: AppTextStyle.body(size: 14),
                    ),
                    TextSpan(     // PinCodeTextField(
                  //   pinTextStyle: AppTextStyle.body(),u
                  //   keyboardType: TextInputType.number,
                  //   maxLength: 6,
                  //   pinBoxRadius: 10,
                  //   pinBoxColor: const Color.fromARGB(13, 255, 255, 255),
                  //   pinBoxWidth: 55,
                  //   pinBoxHeight: 60,
                  //   defaultBorderColor: AppColor.lightgrey,
                  //   hasTextBorderColor: AppColor.primaryColor,
                  //   onTextChanged: (ss) {
                  //     // setState(() {
                  //     //   codeController = ss;
                  //     // });
                  //   },
                  // ),
                      text: '$time ',
                      style: AppTextStyle.body(
                          size: 14,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'seconds ',
                      style: AppTextStyle.body(size: 14),
                    ),
                    TextSpan(
                        text: ' Resend Code',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (time > 0) return;

                            setState(() {
                              isLoarding = true;
                              time = 60;
                            });

                            var response =
                                await authProvider.requestConfirmationToken(
                                    emailOrPhone: widget.emailOrPhone,
                                    confirmationTokenType: widget.channel,
                                    userId: widget.userId);
                            startTime();

                            setState(() {
                              isLoarding = false;
                            });
                          },
                        style: AppTextStyle.body(
                            fontWeight: FontWeight.bold,
                            size: 14,
                            color: AppColor.primaryColor)),
                  ])),
                  SizedBox(height: 70),
                  AppButton(
                      color: pin.length != 6
                          ? AppColor.grey
                          : AppColor.primaryColor,
                      title: 'Verify Account',
                      onTap: () async {
                        if (pin.length != 6) return;
                        setState(() {
                          isLoarding = true;
                        });
                        final response = await authProvider.verifyAccount(
                            token: pin,
                            userId: widget.userId,
                            channel: widget.channel);
                        setState(() {
                          isLoarding = false;
                        });

                        if (response['success']) {
                          log("Signup successful: ${response['data']}");
                          // Navigate to another screen or show success message

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecurityQuestion()));
                        } else {
                          print("Signup failed: ${response['message']}");
                          CustomSnackbar.showError(context,
                              "Error ${response['data']["message"] ?? response['message']}");
                          // Show error message
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SecurityQuestion()));
                      })
                ],
              ),
            ),
    );
  }
}
